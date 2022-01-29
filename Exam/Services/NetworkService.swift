//
//  NetworkService.swift
//  Exam
//
//  Created by Kirill Varshamov on 28.01.2022.
//

import Foundation

final class NetworkService {

    enum NetworkErrors: Error {
        case invalidURL
        case noResponse
        case serverSideError(Int)
        case coruptedData
        case parseError

        var description: String {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .noResponse:
                return "Response is empty"
            case .serverSideError(let statusCode):
                return "The call failed with HTTP code \(statusCode)."
            case .coruptedData:
                return "Corrupted Data"
            case .parseError:
                return "Cannot parse Server Response"
            }
        }
    }

    private let apiKey = "29cd1623e161660071d8ec0ce8f0e6c6"

    // READY: Заменить Result<String, Error> на свою модель и ошибку
    func getWeather(for city: String, completion: @escaping (Result<WeatherRootResponse, NetworkErrors>) -> Void) {

        guard let url = createURL(city: city) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            // READY: Корректно обработать ошибку, респонс и дату

            guard let data = data else {
                completion(.failure(.coruptedData))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }

            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.serverSideError(response.statusCode)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(WeatherRootResponse.self, from: data)

                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.parseError))
            }

        }.resume()
    }

    private func createURL(city: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey)
        ]

        return urlComponents.url
    }

}
