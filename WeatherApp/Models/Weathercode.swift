//
//  Weathercode.swift
//  WeatherApp
//
//  Created by Andrzej Nowitski on 24/02/2023.
//

import UIKit

enum Weathercode: Int, Decodable {
    case clearSky = 0

    case mainlyClear = 1
    case partlyCloudy = 2
    case overcast = 3

    case fog = 45
    case depositingRimeFog = 48

    case drizzleLight = 51
    case drizzleModerate = 53
    case drizzleDenseIntensity = 55

    case freezingDrizzleLight = 56
    case freezingDrizzleDenseIntensity = 57
    
    case rainSlight = 61
    case rainModerate = 63
    case rainHeavyIntensity = 65
    
    case freezingRainLight = 66
    case freezingRainHeavyIntensity = 67
    
    case snowFallSlight = 71
    case snowFallModerate = 73
    case snowFallHeavyIntensity = 75
    
    case snowGrains = 77

    case rainShowersSlight = 80
    case rainShowersModerate = 81
    case rainShowersViolent = 82

    case snowShowersSlight = 85
    case snowShowersHeavy = 86
    
    case notAvailable = -1
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawInt = try container.decode(Int.self)
        if let code = Weathercode(rawValue: rawInt) {
            self = code
        } else {
            self = .notAvailable
        }
    }
}

//0 Ясное небо
//1, 2, 3 В основном ясно, частично облачно и пасмурно
//45, 48 Туман и оседающий известковый туман
//51, 53, 55 Морось: Легкая, умеренная и плотная интенсивность
//56, 57 Моросящий дождь: Легкая и плотная морось
//61, 63, 65 Дождь: слабый, умеренный и сильный

//66, 67 Замораживающий дождь: Легкая и сильная интенсивность

//71, 73, 75 Снегопад: Небольшая, умеренная и сильная интенсивность
//77 Снежные зерна
//80, 81, 82 Дождевые ливни: Незначительные, умеренные и сильные
//85, 86 Снежные ливни слабой и сильной интенсивности

extension Weathercode {
    var decription: String {
        switch self {
        case .clearSky:
            return "Clear Sky"

        case .mainlyClear:
            return "Clear Sky"
    
        case .partlyCloudy:
            return "Clear Sky"
        case .overcast:
            return "Clear Sky"
        case .fog:
            return "Clear Sky"
        case .depositingRimeFog:
            return "Clear Sky"
        case .drizzleLight:
            return "Clear Sky"
        case .drizzleModerate:
            return "Clear Sky"
        case .drizzleDenseIntensity:
            return "Clear Sky"
        case .freezingDrizzleLight:
            return "Clear Sky"
        case .freezingDrizzleDenseIntensity:
            return "Clear Sky"
        case .rainSlight:
            return "Clear Sky"
        case .rainModerate:
            return "Clear Sky"
        case .rainHeavyIntensity:
            return "Clear Sky"
        case .freezingRainLight:
            return "Clear Sky"
        case .freezingRainHeavyIntensity:
            return "Clear Sky"
        case .snowFallSlight:
            return "Clear Sky"
        case .snowFallModerate:
            return "Clear Sky"
        case .snowFallHeavyIntensity:
            return "Clear Sky"
        case .snowGrains:
            return "Clear Sky"
        case .rainShowersSlight:
            return "Clear Sky"
        case .rainShowersModerate:
            return "Clear Sky"
        case .rainShowersViolent:
            return "Clear Sky"
        case .snowShowersSlight:
            return "Clear Sky"
        case .snowShowersHeavy:
            return "Clear Sky"
        case .notAvailable:
            return "Clear Sky"
        }
    }
    
    var smallImage: UIImage {
        switch self {
        case .clearSky:
            return UIImage(named: "clearSky")!

        case .mainlyClear:
            return UIImage(named: "mainlyClear")!

        case .partlyCloudy:
            return UIImage(named: "partlyCloudy")!

        case .overcast:
            return UIImage(named: "overcast")!

        case .fog, .depositingRimeFog:
            return UIImage(named: "fog")!

        case .drizzleLight, .drizzleModerate, .drizzleDenseIntensity, .freezingDrizzleLight, .freezingDrizzleDenseIntensity:
            return UIImage(named: "drizzle")!

        case .rainSlight:
            return UIImage(named: "rainSlight")!

        case .rainModerate:
            return UIImage(named: "rainModerate")!

        case .rainHeavyIntensity:
            return UIImage(named: "rainHeavyIntensity")!

        case .freezingRainLight, .freezingRainHeavyIntensity:
            return UIImage(named: "freezingRain")!

        case .snowFallSlight, .snowFallModerate, .snowFallHeavyIntensity:
            return UIImage(named: "snowFall")!

        case .snowGrains, .rainShowersSlight, .rainShowersModerate, .snowShowersSlight, .snowShowersHeavy, .rainShowersViolent:
            return UIImage(named: "snowGrains")!
            
        case .notAvailable:
            return UIImage(named: "notAvailable")!
        }
    }

    var largeImage: UIImage {
        switch self {
        case .clearSky:
            return UIImage(named: "clearSkyLarge")!

        case .mainlyClear:
            return UIImage(named: "mainlyClearLarge")!

        case .partlyCloudy:
            return UIImage(named: "partlyCloudyLarge")!

        case .overcast:
            return UIImage(named: "overcastLarge")!

        case .fog, .depositingRimeFog:
            return UIImage(named: "fogLarge")!

        case .drizzleLight, .drizzleModerate, .drizzleDenseIntensity, .freezingDrizzleLight, .freezingDrizzleDenseIntensity:
            return UIImage(named: "drizzleLarge")!

        case .rainSlight:
            return UIImage(named: "rainSlightLarge")!

        case .rainModerate:
            return UIImage(named: "rainModerateLarge")!

        case .rainHeavyIntensity:
            return UIImage(named: "rainHeavyIntensityLarge")!

        case .freezingRainLight, .freezingRainHeavyIntensity:
            return UIImage(named: "freezingRainLarge")!

        case .snowFallSlight, .snowFallModerate, .snowFallHeavyIntensity:
            return UIImage(named: "snowFallLarge")!

        case .snowGrains, .rainShowersSlight, .rainShowersModerate, .snowShowersSlight, .snowShowersHeavy, .rainShowersViolent:
            return UIImage(named: "snowGrainsLarge")!

        case .notAvailable:
            return UIImage(named: "notAvailable")!
        }
    }
}
