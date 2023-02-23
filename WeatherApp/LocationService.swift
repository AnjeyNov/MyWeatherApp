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

    lazy private (set) var authorizationStatus = CurrentValueSubject<CLAuthorizationStatus, Never>(locationManager.authorizationStatus)
    let currentLocation = CurrentValueSubject<Location?, Never>(nil)

    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        locationManager.delegate = self
    
    }

    private func geocodeLocation(with latitude: CLLocationDegrees, and longitude: CLLocationDegrees) {
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: latitude, longitude: longitude)
            geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en_US"), completionHandler: { [weak self] (placemarks, error) in
                guard let self = self, error == nil else { return }

                if let placemarks = placemarks, let placemark = placemarks.first, let city = placemark.locality {
                    self.currentLocation.value = Location(city: city, latitude: latitude, longitude: longitude)
                    self.locationManager.stopUpdatingLocation()
                } else {
                    print("No Matching Address Found")
                }
            })
        }

}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus.value = manager.authorizationStatus
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            geocodeLocation(with: location.coordinate.latitude, and: location.coordinate.longitude)
        }
    }
}
