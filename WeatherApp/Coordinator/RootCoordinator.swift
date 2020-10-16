//
//  RootCoordinator.swift
//  WeatherApp
//
//  Created by Triet Le on 16.10.2020.
//

import UIKit

class RootCoordinator {

    // MARK: - Private properties
    private let window: UIWindow
    private let navigationController: UINavigationController

    // MARK: - Init
    init(window: UIWindow) {
        self.window = window

        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
        navigationController.navigationBar.isTranslucent = true
    }

}

// MARK: - Coordinator
extension RootCoordinator: Coordinator {
    func start() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)

        let networkManager = NetworkManager(baseUrlString: AppPantry.baseUrlString, decoder: decoder)
        let viewModel = RootViewModel(networkManager: networkManager)
        let rootViewController = RootViewController(viewModel: viewModel)

        navigationController.setViewControllers([rootViewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
