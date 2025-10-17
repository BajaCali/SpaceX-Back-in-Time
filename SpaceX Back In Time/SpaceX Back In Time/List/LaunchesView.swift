import SwiftUI
import UIKit

struct LaunchesView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let launchesVC = LaunchesViewController()

        let navigationController = UINavigationController(rootViewController: launchesVC)
        navigationController.navigationBar.prefersLargeTitles = true

        return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // no updates needed
    }
}

#Preview {
    LaunchesView()
}
