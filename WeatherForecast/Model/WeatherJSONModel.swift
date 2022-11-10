//
//  WeatherJSONModel.swift
//  WeatherForecast
//
//  Created by Artyom Potapov on 09.11.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let posts = try? newJSONDecoder().decode(WeatherJSONModel.self, from: jsonData)

import Foundation

// MARK: - Posts
struct WeatherJSONModel: Codable {

    let info: Info
    let fact: Fact
    let forecasts: [Forecast]

    enum CodingKeys: String, CodingKey {
        case info
        case fact, forecasts
    }
}
// MARK: - Info
struct Info: Codable {
    let url: String

}
// MARK: - Fact
struct Fact: Codable {
    let temp: Int
    let icon: Icon
    let condition: Condition
    let windSpeed: Double
    let pressureMm, humidity, feelsLike: Int
  

    enum CodingKeys: String, CodingKey {
        case temp, humidity
        case icon, condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
        case feelsLike = "feels_like"
    }
}

enum Condition: String, Codable {
    case cloudy = "cloudy"
    case lightRain = "light-rain"
    case overcast = "overcast"
}

enum Icon: String, Codable {
    case bknD = "bkn_d"
    case ovc = "ovc"
    case ovcRa = "ovc_-ra"
}

// MARK: - Forecast
struct Forecast: Codable {
    let parts: Parts
    let sunrise, sunset, riseBegin, setEnd: String
    let tempMin, tempMax: Int?
    
    enum CodingKeys: String, CodingKey {
        case parts
        case sunrise, sunset
        case riseBegin = "rise_begin"
        case setEnd = "set_end"
        case tempMin, tempMax
    }
}
struct Parts: Codable {
    let day: Hour
}

struct Hour: Codable {
    let tempMin, tempMax: Int?
}
