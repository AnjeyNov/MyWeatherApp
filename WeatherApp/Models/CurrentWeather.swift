//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import Foundation

struct CurrentWeather: Decodable {
    let temperature: Double
    let windspeed: Double
    let weathercode: Int
}
