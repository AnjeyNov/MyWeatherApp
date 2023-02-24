//
//  HourlyWeatherDate.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import Foundation

struct HourlyWeather {
    let date: Date
    let temperature: Double
    let weathercode: Weathercode
    
    init?(date: String, temperature: Double, weathercode: Weathercode) {
        guard let date = Formatters.shared.defaultFormatter.date(from: date) else { return nil }
        self.date = date
        self.temperature = temperature
        self.weathercode = weathercode
    }
}

fileprivate class Formatters {
    static let shared = Formatters()

    let defaultFormatter = DateFormatter()

    private init() {
        defaultFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        defaultFormatter.locale = Locale(identifier: "en_US")
        defaultFormatter.timeZone = TimeZone.current
    }
}
