//
//  DailyWeatherData.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import Foundation

struct DailyWeatherData {
    let date: Date
    let maxTemperature: Double
    let minTemperature: Double
    
    init?(date: String, maxTemperature: Double, minTemperature: Double) {
        guard let date = Formatters.shared.defaultFormatter.date(from: date) else { return nil }
        self.date = date
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
    }
}

fileprivate class Formatters {
    static let shared = Formatters()

    let defaultFormatter = DateFormatter()

    private init() {
        defaultFormatter.dateFormat = "yyyy-MM-dd"
        defaultFormatter.locale = Locale(identifier: "en_US")
        defaultFormatter.timeZone = TimeZone.current
    }
}
