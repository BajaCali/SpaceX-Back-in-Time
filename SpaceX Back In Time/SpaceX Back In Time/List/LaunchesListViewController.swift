import UIKit
import SwiftUI

class LaunchesViewController: UIViewController {
    private let tableView = UITableView()
    private var launches: [Launch] = Launch.mockLaunches

    private let cellIdentifier = "LaunchCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupViewUI()
        attachDelegates()
        registerCell()
        attachTableView()
    }

    private func setupViewUI() {
        self.title = "Rocket Launches 🚀"
        self.toolbarItems = [ ]
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

extension LaunchesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let launch = launches[indexPath.row]

        cell.contentConfiguration = UIHostingConfiguration { RowView(launch: launch) }
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedLaunch = launches[indexPath.row]
        print("Tapped on: \(selectedLaunch.title)")
    }
}
