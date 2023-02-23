//
//  TutorialCoordinator.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import UIKit

class TutorialCoordinator: CoordinatorDependable {
    private unowned let launcher: Launcher
    private let navigationController = UINavigationController()

    var childCoordinators: [CoordinatorDependable] = []
    var parentCoordinator: CoordinatorDependable?

    init(with launcher: Launcher) {
        self.launcher = launcher
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
    }

    func start() {
        navigationController.pushViewController(
            FirstTutorialScreenViewController(
                viewModel: FirstTutorialScreenViewModel(router: self)
            ),
            animated: true
        )
        launcher.present(navigationController)
    }

    private func showSecondTutorial() {
        navigationController.pushViewController(
            SecondTutorialScreenViewController(
                viewModel: SecondTutorialScreenViewModel(router: self)
            ),
            animated: true
        )
    }
}

extension TutorialCoordinator: FirstTutorialScreenRouting {
    func endFirstTutorial() {
        showSecondTutorial()
    }
}

extension TutorialCoordinator: SecondTutorialScreenRouting {
    func endSecondTutorial() {
        navigationController.dismiss(animated: false)
        finish()
    }
}
