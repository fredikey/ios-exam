//
//  WeatherViewModelFactory.swift
//  Exam
//
//  Created by Kirill Varshamov on 29.01.2022.
//

import Foundation

final class WeatherViewModelFactory {
    func viewModel(from model: WeatherRootResponse) -> WeatherViewModel {
        // MARK: Передать в данный метод свою модель с сетевого слоя
        // Распарсить сетевую модель во вью модель

        let row = WeatherRow(locationName: model.name,
                             temp: KelvinToCelsius(model.info.temp),
                             feelsLike: KelvinToCelsius(model.info.feelsLike),
                             tempMin: KelvinToCelsius(model.info.tempMin),
                             tempMax: KelvinToCelsius(model.info.tempMax),
                             pressure: model.info.pressure,
                             humidity: model.info.humidity,
                             clouds: model.clouds.all)

        return WeatherViewModel(sections: [WeatherSection(rows: [row])])
    }

    private func KelvinToCelsius(_ value: Double) -> Int {
        return Int(value - 273)
    }

}
