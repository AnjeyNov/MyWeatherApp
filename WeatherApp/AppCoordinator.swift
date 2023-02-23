//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import UIKit
import CoreLocation

class AppCoordinator: CoordinatorDependable {
    private let launcher: Launcher

    var isFirstLaunch: Bool {
        didSet {
            UserDefaults.standard.set(isFirstLaunch, forKey: .kIsFirstLaunch)
        }
    }
    
    var childCoordinators: [CoordinatorDependable] = []
    var parentCoordinator: CoordinatorDependable?

    init(with launcher: Launcher) {
        self.launcher = launcher
        if let isFirst = UserDefaults.standard.object(forKey: .kIsFirstLaunch) as? Bool {
            isFirstLaunch = isFirst
        } else {
            isFirstLaunch = true
        }
    }
    
    func start() {
        run(WeatherCoordinator(with: launcher))

        if isFirstLaunch {
            run(TutorialCoordinator(with: launcher))
            isFirstLaunch = false
        }
    }
}

fileprivate extension String {
    static let kIsFirstLaunch = "is_first_lounch"
}
