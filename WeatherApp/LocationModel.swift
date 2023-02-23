//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import CoreLocation

struct Location: Equatable {
    let city: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}
