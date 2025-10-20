import UIKit
import SwiftUI
import Combine

class LaunchesViewController: UIViewController {
    private let tableView = UITableView()
    private let backgroundView = UIView()
    private var detailViewController: UIHostingController<LaunchDetailView>?

    private var viewModel = ViewModel()

    private var bindings = Set<AnyCancellable>()
}

// MARK: - Cells

extension LaunchesViewController {
    enum CellId: String, CaseIterable {
        case launch
        case loading
    }
}

// MARK: - Life Cycle

extension LaunchesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModelUpdates()
        viewModel.onAppear()
    }
}

// MARK: - View Setup

extension LaunchesViewController {
    private func setupUI() {
        setupBackground()
        attachDelegates()
        registerCells()
        attachTableView()
        setupNavigationBar()
    }

    private func setupBackground() {
        let swiftUIView = UIHostingController(rootView: BackgroundView(initialState: viewModel.state))

        backgroundView.addSubview(swiftUIView.view)

        swiftUIView.view.pin(to: backgroundView)
        tableView.backgroundView = backgroundView
    }

    private func setupNavigationBar() {
        self.title = "Rocket Launches 🚀"
        addToolbarButton()
        addSearchBar()
    }

    private func addSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Launches"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func addToolbarButton() {
        let sortIcon = UIImage(systemName: "arrow.up.arrow.down.circle")

        let sortButton = UIBarButtonItem(
            image: sortIcon,
            style: .plain,
            target: self,
            action: #selector(showActionSheet(_:))
        )

        self.navigationItem.rightBarButtonItem = sortButton
    }

    private func attachDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func registerCells() {
        for cellId in CellId.allCases.map(\.rawValue) {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        }
    }

    private func attachTableView() {
        view.addSubview(tableView)
        tableView.pin(to: view)
    }
}

// MARK: - ViewModel Bindings

extension LaunchesViewController {
    private func bindViewModelUpdates() {
        viewModel.$launches
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.refreshTableView()
            }
            .store(in: &bindings)

        viewModel.$searchText
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.refreshTableView()
            }
            .store(in: &bindings)

        viewModel.$errorMessage
            .compactMap(\.self)
            .sink { [weak self] errorMessage in
                self?.showErrorMessageAlert(errorMessage)
            }
            .store(in: &bindings)

        viewModel.$state
            .sink { [weak self] state in
                self?.setScrolling(basedOn: state)
                self?.refreshTableView()
            }
            .store(in: &bindings)

        viewModel.$launchInDetail
            .sink { [weak self] launch in
                launch.flatMap {
                    self?.updateDetailsTitle(of: $0)
                }
            }
            .store(in: &bindings)
    }
}

// MARK: - View Updates

extension LaunchesViewController {
    private func setScrolling(basedOn state: ViewModel.State) {
        Task {
            await MainActor.run {
                switch state {
                case .initial, .loading, .networkIssue:
                    tableView.isScrollEnabled = false
                case .loadingMore, .loadingMoreFailed, .loaded, .noSearchResults:
                    tableView.isScrollEnabled = true
                }
            }
        }
    }

    @objc private func showActionSheet(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(
            title: "Order by",
            message: """
Select a field to which to order.
Select again to reverse.

Currently sorted \(viewModel.ordering.humanDescription).
""",
            preferredStyle: .actionSheet
        )

        let possibleOrderings: [Ordering] = [
            Ordering(field: .byName, direction: .ascending),
            Ordering(field: .byFlightNumber, direction: .ascending)
        ]

        for ordering in possibleOrderings {
            let (nameTitle, newOrdering) = title(for: ordering)
            let action = UIAlertAction(title: nameTitle, style: .default) { _ in
                self.viewModel.tappedButtonToChangeOrdering(to: newOrdering)
            }
            actionSheet.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true)
    }

    /// Besides returning the title for action button, function also return ordering to which it should change
    /// upon tapping.
    private func title(for ordering: Ordering) -> (String, Ordering) {
        var newOrdering = ordering
        let checkmark = if ordering.field == viewModel.ordering.field {
            "✓ "
        } else {
            ""
        }
        if ordering == viewModel.ordering {
            newOrdering.direction = switch ordering.direction {
            case .ascending: .descending
            case .descending: .ascending
            }
        }

        let title = checkmark + newOrdering.humanDescription
        return (title, newOrdering)

    }

    private func showErrorMessageAlert(_ message: String) {
        Task {
            await MainActor.run {
                let confirmAction = UIAlertAction(
                    title: "Ok",
                    style: .cancel
                ) { [weak self] _ in
                    self?.viewModel.errorOkButtonTapped()
                }

                let tryAgainAction = UIAlertAction(
                    title: "Try Again",
                    style: .default
                ) { [weak self] _ in
                    self?.viewModel.errorTryAgainButtonTapped()
                }

                let alert = UIAlertController(
                    title: "Network Error",
                    message: message,
                    preferredStyle: .alert
                )

                alert.addAction(confirmAction)
                alert.addAction(tryAgainAction)

                self.present(alert, animated: true)
            }
        }
    }

    private func pushDetail(for launch: Launch) {
        guard let detailState = viewModel
            .generateDetailState(for: launch) else {
            return
        }
        let detailController = UIHostingController(rootView: LaunchDetailView(.init(detailState)))
        detailController.title = launch.title
        navigationController?.pushViewController(detailController, animated: true)
        self.detailViewController = detailController
        viewModel.detailPushed(with: launch)
    }

    private func updateDetailsTitle(of launch: Launch) {
        detailViewController?.title = launch.title
    }
}

// MARK: - Search

extension LaunchesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchText = searchController.searchBar.text ?? ""
    }
}

// MARK: - TableView

extension LaunchesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredLaunches.count + (viewModel.state == .loadingMore ? 1 : 0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.rendering(row: indexPath.row)

        if indexPath.row < viewModel.filteredLaunches.count {
            return launchCell(indexPath: indexPath)
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.loading.rawValue, for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration { LoadingRow() }

        return cell
    }

    private func launchCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.launch.rawValue, for: indexPath)
        let launch = viewModel.filteredLaunches[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration { RowView(launch: launch) }
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedLaunch = viewModel.filteredLaunches[indexPath.row]
        pushDetail(for: selectedLaunch)
        viewModel.detailPushed(with: selectedLaunch)
    }

    private func refreshTableView() {
        Task {
            await MainActor.run {
                tableView.reloadData()
            }
        }
    }
}
