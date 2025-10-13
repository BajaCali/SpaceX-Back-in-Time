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
        self.title = "Rocket Launches 🚀"
        self.toolbarItems = [ ]
    }

        // Configure Table View
        tableView.dataSource = self // Set the data source
        tableView.delegate = self   // Set the delegate
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier) // Register a cell type

        // Add table view to the view hierarchy
        view.addSubview(tableView)

        // Set up constraints for the table view to fill the screen
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
