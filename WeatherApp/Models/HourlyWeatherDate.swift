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
    
    init?(date: String, temperature: Double) {
        guard let date = Formatters.shared.defaultFormatter.date(from: date) else { return nil }
        self.date = date
        self.temperature = temperature
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
