//
//  Weather.swift
//  WeatherForecast
//
//  Created by Artyom Potapov on 09.11.2022.
//

import Foundation

struct Weather{
    
    var name: String = "Название"
    var temperature: Int
    var conditionCode: String = Constants.conditionCode
    var condition: Condition
    let icon: Icon
    var url: String
    var pressure: Int
    var feelsLike: Int
    var windSpeed: Double
    var humidity: Int
    var tempMin: Int?
    var tempMax: Int?
    
    var conditionString: String {
        switch condition.rawValue {
            
        case "clear": return "ясно"
        case "partly-cloudy": return "малооблачно"
        case "cloudy": return "облачно с прояснениями"
        case "overcast": return "пасмурно"
        case "drizzle": return "морось"
        case "light-rain": return "небольшой дождь"
        case "rain": return "дождь"
        case "moderate-rain": return "умеренно сильный дождь"
        case "heavy-rain": return "сильный дождь"
        case "continuous-heavy-rain": return "длительный сильный дождь"
        case "showers": return "ливень"
        case "wet-snow": return "дождь со снегом"
        case "light-snow": return "небольшой снег"
        case "snow": return "снег"
        case "snow-showers": return "снегопад"
        case "hail": return "град"
        case "thunderstorm": return "гроза"
        case "thunderstorm-with-rain": return "дождь с грозой"
        case "thunderstorm-with-hail": return "гроза с градом"
        default: return "Загрузка..."
        }
    }
    
    init?(weatherJSONModel: WeatherJSONModel){
        temperature = weatherJSONModel.fact.temp
        condition = weatherJSONModel.fact.condition
        humidity = weatherJSONModel.fact.humidity
        icon = weatherJSONModel.fact.icon
        url = weatherJSONModel.info.url
        pressure = weatherJSONModel.fact.pressureMm
        windSpeed = weatherJSONModel.fact.windSpeed
        feelsLike = weatherJSONModel.fact.feelsLike
        tempMin = weatherJSONModel.forecasts.first?.parts.day.tempMin
        tempMax = weatherJSONModel.forecasts.first?.parts.day.tempMax
    }
    init(){
        temperature = 0
        condition = .cloudy
        icon = .bknD
        url = ""
        pressure = 0
        feelsLike = 0
        windSpeed = 0
        tempMin = 0
        tempMax = 0
        humidity = 0
    }
}
