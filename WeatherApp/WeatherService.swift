//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 22/02/2023.
//

import Combine
import CoreLocation

class WeatherService {
    
    static let shared = WeatherService()
    let weatherData = CurrentValueSubject<WeatherData?, Never>(nil)

    private var cancellables: Set<AnyCancellable> = []
    
    private init() {
        LocationService
            .shared
            .currentLocation
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .removeDuplicates()
            .sink { [unowned self] in fetchWeatherFor($0) }
            .store(in: &cancellables)
    }
        
    private func fetchWeatherFor(_ location: Location) {
        print(location)
    }
}

