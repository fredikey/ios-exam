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
    var title: String
    var data: String
}
