import UIKit
import SwiftUI
import Combine

class LaunchesViewController: UIViewController {
    private let tableView = UITableView()
    private let backgroundView = UIView()

    private var viewModel = ViewModel()

    private var cancellables = Set<AnyCancellable>()

    private let cellIdentifier = "LaunchCell"
}

// MARK: - Life Cycle

extension LaunchesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModelUpdates()
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.onAppear()
    }
}

// MARK: - View Setup

extension LaunchesViewController {
    private func setupUI() {
        setupBackground()
        attachDelegates()
        registerCell()
        attachTableView()
        setupNavigationBar()
    }

    private func setupBackground() {
        let swiftUIView = UIHostingController(rootView: BackgroundView(initialState: viewModel.state))

        backgroundView.addSubview(swiftUIView.view)
        backgroundView.layoutSubviews()

        swiftUIView.view.pin(to: backgroundView)
        tableView.backgroundView = backgroundView
    }

    private func setupNavigationBar() {
        self.title = "Rocket Launches 🚀"
        addToolbarButton()
    }

    private func addToolbarButton() {
        let testButtonVC = UIHostingController(rootView: ToolbarButton(action: viewModel.testButtonTapped))
        let barButton = UIBarButtonItem(customView: testButtonVC.view)
        testButtonVC.view.backgroundColor = .clear
        self.navigationItem.rightBarButtonItem = barButton
    }

    private func attachDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    private func attachTableView() {
        view.addSubview(tableView)
        tableView.pin(to: view)
    }
}

// MARK: - ViewModelBindings

extension LaunchesViewController {
    private func bindViewModelUpdates() {
        viewModel
            .$launches
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { [weak self] newLaunches in
            print(newLaunches.count)
            self?.tableView.reloadData()
        }
        .store(in: &cancellables)
    }
}

// MARK: - TableView connection

extension LaunchesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.launches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let launch = viewModel.launches[indexPath.row]

        cell.contentConfiguration = UIHostingConfiguration { RowView(launch: launch) }
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedLaunch = viewModel.launches[indexPath.row]
        viewModel.launchTapped(selectedLaunch)
    }
}
