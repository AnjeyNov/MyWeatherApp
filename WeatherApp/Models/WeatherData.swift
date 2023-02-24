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
    let dailyWeather: [DailyWeatherData]

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
    
    enum CodingKeys: String, CodingKey {
        case dates = "time"
        case temperatures = "temperature_2m"
    }
    
    var hourlyWeather: [HourlyWeather] {
        guard dates.count == temperatures.count else { return [] }
        return dates.enumerated().compactMap { [temperatures] (index, date) in
            HourlyWeather(date: date, temperature: temperatures[index])
        }
    }
}

fileprivate struct RawDailyWeather: Decodable {
    let dates: [String]
    let temperaturesMin: [Double]
    let temperaturesMax: [Double]
    
    enum CodingKeys: String, CodingKey {
        case dates = "time"
        case temperaturesMin = "temperature_2m_min"
        case temperaturesMax = "temperature_2m_max"
    }
    
    var dailyWeather: [DailyWeatherData] {
        guard dates.count == temperaturesMax.count, temperaturesMax.count == temperaturesMin.count else { return [] }
        return dates.enumerated().compactMap { [temperaturesMin, temperaturesMax] (index, date) in
            DailyWeatherData(date: date, maxTemperature: temperaturesMax[index], minTemperature: temperaturesMin[index])
        }
    }
}
