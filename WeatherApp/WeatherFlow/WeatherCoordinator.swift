//
//  WeatherCoordinator.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import UIKit

class WeatherCoordinator: CoordinatorDependable {
    private unowned let launcher: Launcher
    private let navigationController = UINavigationController()

    var childCoordinators: [CoordinatorDependable] = []
    var parentCoordinator: CoordinatorDependable?

    init(with launcher: Launcher) {
        self.launcher = launcher
    }
    
    func start() {
        navigationController.pushViewController(
            LoadingViewController(
                nibName: "LoadingViewController",
                bundle: nil
            ),
            animated: true
        )
        launcher.root = navigationController
    }
}
