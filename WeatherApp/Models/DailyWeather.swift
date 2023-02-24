//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import Foundation

struct DailyWeather {
    private let date: Date
    let maxTemperature: Double
    let minTemperature: Double
    let weathercode: Weathercode
    
    var dayOfWeek: String? { Formatters.shared.toDayOfWeekFormatter.string(from: date) }
    
    init?(date: String, maxTemperature: Double, minTemperature: Double, weathercode: Weathercode) {
        guard let date = Formatters.shared.defaultFormatter.date(from: date) else { return nil }
        self.date = date
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
        self.weathercode = weathercode
    }
}

fileprivate class Formatters {
    static let shared = Formatters()

    let defaultFormatter = DateFormatter()
    let toDayOfWeekFormatter = DateFormatter()

    private init() {
        defaultFormatter.dateFormat = "yyyy-MM-dd"
        defaultFormatter.locale = Locale(identifier: "en_US")
        defaultFormatter.timeZone = TimeZone.current
        
        toDayOfWeekFormatter.dateFormat = "EEEE"
        toDayOfWeekFormatter.locale = Locale(identifier: "en_US")
        toDayOfWeekFormatter.timeZone = TimeZone.current
    }
}
