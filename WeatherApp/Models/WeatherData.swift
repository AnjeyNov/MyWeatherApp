//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import Foundation

struct WeatherData: Decodable {
    let currentWeather: CurrentWeather
    let hourlyWeather: [HourlyWeather]
    let dailyWeather: [DailyWeather]

    enum CodingKeys: String, CodingKey {
        case currentWeather = "current_weather"
        case hourly
        case daily
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        currentWeather = try container.decode(CurrentWeather.self, forKey: .currentWeather)
        
        let rawHourly = try container.decode(RawHourlyWeather.self, forKey: .hourly)
        hourlyWeather = rawHourly.hourlyWeather
        
        let rawDaily = try container.decode(RawDailyWeather.self, forKey: .daily)
        dailyWeather = rawDaily.dailyWeather
    }
}

fileprivate struct RawHourlyWeather: Decodable {
    let dates: [String]
    let temperatures: [Double]
    let weathercodes: [Weathercode]
    
    enum CodingKeys: String, CodingKey {
        case dates = "time"
        case temperatures = "temperature_2m"
        case weathercodes = "weathercode"
    }
    
    var hourlyWeather: [HourlyWeather] {
        guard dates.count == temperatures.count,
              temperatures.count == weathercodes.count else { return [] }

        return dates.enumerated().compactMap { [temperatures, weathercodes] (index, date) in
            HourlyWeather(
                date: date,
                temperature: temperatures[index],
                weathercode: weathercodes[index]
            )
        }
    }
}

fileprivate struct RawDailyWeather: Decodable {
    let dates: [String]
    let temperaturesMin: [Double]
    let temperaturesMax: [Double]
    let weathercodes: [Weathercode]
    
    enum CodingKeys: String, CodingKey {
        case dates = "time"
        case temperaturesMin = "temperature_2m_min"
        case temperaturesMax = "temperature_2m_max"
        case weathercodes = "weathercode"
    }
    
    var dailyWeather: [DailyWeather] {
        guard dates.count == temperaturesMax.count,
              temperaturesMax.count == temperaturesMin.count,
              temperaturesMin.count == weathercodes.count else { return [] }

        return dates.enumerated().compactMap { [temperaturesMin, temperaturesMax, weathercodes] (index, date) in
            DailyWeather(
                date: date,
                maxTemperature: temperaturesMax[index],
                minTemperature: temperaturesMin[index],
                weathercode: weathercodes[index]
            )
        }
    }
}
