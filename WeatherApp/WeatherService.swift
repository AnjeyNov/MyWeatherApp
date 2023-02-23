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
        
    }
}

fileprivate extension String {
    static var baseURLString: String { "https://api.open-meteo.com/" }
    static var getWeatherEndPoint: String { "v1/forecast" }
    static var latitude: String { "latitude" }
    static var longitude: String { "longitude" }
    static var hourly: String { "hourly" }
    static var temperature_2m: String { "temperature_2m" }
    static var weathercode: String { "weathercode" }
    static var currentWeather: String { "current_weather" }
    static var timezone: String { "timezone" }
}
