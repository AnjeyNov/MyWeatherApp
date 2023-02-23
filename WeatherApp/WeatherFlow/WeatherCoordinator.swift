//
//  WeatherCoordinator.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import UIKit
import Combine

class WeatherCoordinator: CoordinatorDependable {
    private unowned let launcher: Launcher
    private let navigationController = UINavigationController()
    private var cancellables: Set<AnyCancellable> = []

    var childCoordinators: [CoordinatorDependable] = []
    var parentCoordinator: CoordinatorDependable?


    init(with launcher: Launcher) {
        self.launcher = launcher
        
        LocationService
            .shared
            .authorizationStatus
            .receive(on: DispatchQueue.main)
            .map { $0 == .denied }
            .removeDuplicates()
            .sink { [unowned self] in
                guard $0 else { return }
                presentAlert()
            }
            .store(in: &cancellables)
        
        WeatherService
            .shared
            .weatherData
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] in
                print($0)
            }
            .store(in: &cancellables)
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

    private func presentAlert() {
        launcher.presentAlert(.alertTitle, .alertMessage, buttonText: .ok)
    }
}

fileprivate extension String {
    static var alertTitle: String { "Geolocation services must be enabled." }
    static var alertMessage: String { "The geolocation service must be used for the application to work properly." }
    static var ok: String { "Ok" }
}
