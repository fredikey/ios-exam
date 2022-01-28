//
//  NetworkService.swift
//  Exam
//
//  Created by Kirill Varshamov on 28.01.2022.
//

import Foundation

final class NetworkService {
    
    private let apiKey = "29cd1623e161660071d8ec0ce8f0e6c6"
    
    // MARK: Заменить Result<String, Error> на свою модель и ошибку
    func getWeather(for city: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey)
        ]

        guard let url = urlComponents.url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // MARK: Корректно обработать ошибку, респонс и дату
            
            guard let data = data else {
                return
            }

            guard let string = String(data: data, encoding: .utf8) else {
                return
            }
            
            completion(.success(string))
            
        }.resume()
    }
    
}
