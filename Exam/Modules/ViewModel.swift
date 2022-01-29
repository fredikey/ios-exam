//
//  ViewModel.swift
//  Exam
//
//  Created by Kirill Varshamov on 29.01.2022.
//

import Foundation

struct WeatherViewModel {
    var sections: [WeatherSection]
}

struct WeatherSection {
    var rows: [WeatherRow]
}

struct WeatherRow {
    var locationName: String
    var temp: Int
    var feelsLike: Int
    var tempMin: Int
    var tempMax: Int
    var pressure: Int
    var humidity: Int
    var clouds: Int
}
