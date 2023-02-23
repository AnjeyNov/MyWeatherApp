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
    
    var childCoordinators: [CoordinatorDependable] = []
    var parentCoordinator: CoordinatorDependable?

    init(with launcher: Launcher) {
        self.launcher = launcher
    }
    
    func start() {
        run(WeatherCoordinator(with: launcher))

        let locationManager = CLLocationManager()
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            run(TutorialCoordinator(with: launcher))
        default:
            break
        }
    }
}


