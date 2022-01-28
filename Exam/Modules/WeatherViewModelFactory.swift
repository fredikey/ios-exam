//
//  WeatherViewModelFactory.swift
//  Exam
//
//  Created by Kirill Varshamov on 29.01.2022.
//

import Foundation

final class WeatherViewModelFactory {
    func viewModel(from model: String) -> WeatherViewModel {
        // MARK: Передать в данный метод свою модель с сетевого слоя
        // Распарсить сетевую модель во вью модель
        
        let testRow = WeatherRow(title: "TestData", data: model)
        
        return WeatherViewModel(sections: [WeatherSection(rows: [testRow])])
    }
}
