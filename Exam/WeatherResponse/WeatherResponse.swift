//
//  WeatherResponse.swift
//  Exam
//
//  Created by Viсtor Kozodaev on 1/29/22.
//

import Foundation

struct WeatherRootResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case info = "main"
        case name
        case clouds
    }

    var info: WeatherInfo
    var name: String
    var clouds: WeatherClouds

    struct WeatherInfo: Codable {
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
        }

        var temp: Double
        var feelsLike: Double
        var tempMin: Double
        var tempMax: Double
        var pressure: Int
        var humidity: Int
    }

    struct WeatherClouds: Codable {
        var all: Int
    }


}



