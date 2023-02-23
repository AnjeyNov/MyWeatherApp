//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 23/02/2023.
//

import Foundation

struct WeatherData: Decodable {
//    let location: Location
    let currentWeather: CurrentWeather

}

struct CurrentWeather: Decodable {
    let temperature: Double
    let windspeed: Double
    let weathercode: Int
}
