//
//  LocationService.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import CoreLocation
import Combine

class LocationService: NSObject {
    static let shared = LocationService()

    private var cancellables: Set<AnyCancellable> = []

    lazy private (set) var authorizationStatus = CurrentValueSubject<CLAuthorizationStatus, Never>(locationManager.authorizationStatus)

    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        locationManager.delegate = self
        
        authorizationStatus
            .receive(on: DispatchQueue.main)
            .map { $0 == .notDetermined }
            .removeDuplicates()
            .sink { [unowned self] in
                guard $0 else { return }
                locationManager.requestAlwaysAuthorization()
            }
            .store(in: &cancellables)
    }

}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus.value = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // Handle location update
        }
    }
}
