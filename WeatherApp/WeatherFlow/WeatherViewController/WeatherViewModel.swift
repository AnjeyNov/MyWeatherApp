//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import Foundation

struct WeatherViewModel {
    let location: Location
    private let weatherData: WeatherData
    
    var currentWeather: CurrentWeather { weatherData.currentWeather }
    var hourlyWeather: [HourlyWeather] { weatherData.hourlyWeather }
    var dailyWeather: [DailyWeather] { weatherData.dailyWeather }
    
    init(location: Location, weatherData: WeatherData) {
        self.location = location
        self.weatherData = weatherData
    }
}
