//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import Foundation

fileprivate class Formatters {
    static let shared = Formatters()

    let defaultFormatter = DateFormatter()

    private init() {
        defaultFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        defaultFormatter.locale = Locale(identifier: "en_US")
        defaultFormatter.timeZone = TimeZone.current
    }

}

struct WeatherData: Decodable {
    let currentWeather: CurrentWeather
    let hourly: [HourlyWeather]

    enum CodingKeys: String, CodingKey {
        case currentWeather = "current_weather"
        case hourly
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        currentWeather = try container.decode(CurrentWeather.self, forKey: .currentWeather)
        let rawHourly = try container.decode(RawHourlyWeather.self, forKey: .hourly) //try container.decode([String: AnyObject].self, forKey: .hourly)
        hourly = rawHourly.hourlyWeather
    }
}

fileprivate struct RawHourlyWeather: Decodable {
    let dates: [String]
    let temperatures: [Double]
    
    enum CodingKeys: String, CodingKey {
        case dates = "time"
        case temperatures = "temperature_2m"
    }
    
    var hourlyWeather: [HourlyWeather] {
        zip(dates, temperatures).compactMap { HourlyWeather(date: $0, temperature: $1) }
    }
}

struct CurrentWeather: Decodable {
    let temperature: Double
    let windspeed: Double
    let weathercode: Int
}

struct HourlyWeather {
    let date: Date
    let temperature: Double
    
    init?(date: String, temperature: Double) {
        guard let date = Formatters.shared.defaultFormatter.date(from: date) else { return nil }
        self.date = date
        self.temperature = temperature
    }
}
