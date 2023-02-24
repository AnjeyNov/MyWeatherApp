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
    let weatherData = PassthroughSubject<(WeatherData, Location), Never>()
    let error = PassthroughSubject<ServerError, Never>()

    private lazy var urlSession = URLSession.shared
    private lazy var cancellables: Set<AnyCancellable> = []
    private var currentTask: AnyCancellable?
    
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
        
    func fetchWeatherFor(_ location: Location) {
        let queryItems = [
            URLQueryItem(name: .latitude, value: "\(location.latitude)"),
            URLQueryItem(name: .longitude, value: "\(location.longitude)"),
            URLQueryItem(name: .hourly, value: .hourlyParams),
            URLQueryItem(name: .daily, value: .dailyParams),
            URLQueryItem(name: .currentWeather, value: "true"),
            URLQueryItem(name: .timezone, value: TimeZone.current.identifier)
        ]
        
        let urlComponents = NSURLComponents(string: .baseURLString + .getWeatherEndPoint)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return }
        currentTask = urlSession
            .dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    guard (200..<300).contains(httpResponse.statusCode) else {
                        throw try JSONDecoder().decode(ServerError.self, from: data)
                    }
                }
                return data
            }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .mapError { ServerError(fromError: $0) }
            .sink(
                receiveCompletion: { [weak self] in
                    guard case let .failure(error) = $0 else { return }
                    self?.error.send(error)
                },
                receiveValue: { [weak self] in
                    self?.weatherData.send(($0, location))
                }
            )
    }
}

fileprivate extension String {
    static var baseURLString: String { "https://api.open-meteo.com/" }
    static var getWeatherEndPoint: String { "v1/forecast" }
    static var latitude: String { "latitude" }
    static var longitude: String { "longitude" }
    static var hourly: String { "hourly" }
    static var hourlyParams: String { "temperature_2m,weathercode" }
    static var daily: String { "daily" }
    static var dailyParams: String { "temperature_2m_max,temperature_2m_min,weathercode"}
    static var currentWeather: String { "current_weather" }
    static var timezone: String { "timezone" }
}
