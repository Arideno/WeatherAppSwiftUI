//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Andrii Moisol on 29.03.2021.
//

import Foundation

struct WeatherData: Codable, Identifiable {
    
    var id: Int?
    var main: Main?
    var weather: [Weather]?
    var wind: Wind?
    
    struct Weather: Codable {
        var main: String?
        var description: String?
    }
    
    struct Main: Codable {
        var temp: Double?
        var feelsLike: Double?
        var tempMin: Double?
        var tempMax: Double?
        
        enum CodingKeys: String, CodingKey {
            case temp = "temp"
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    struct Wind: Codable {
        var speed: Double?
        var deg: Double?
    }
    
}
