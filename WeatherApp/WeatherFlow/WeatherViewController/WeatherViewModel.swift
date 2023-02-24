//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import Foundation

struct WeatherViewModel {
    let location: Location
    private let weatherData: WeatherData
    
    init(location: Location, weatherData: WeatherData) {
        self.location = location
        self.weatherData = weatherData
    }
}
