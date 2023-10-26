//
//  MockWeatherApiService.swift
//  WeatherApplicationTests
//
//  Created by Jaydip Parmar on 15/10/23.
//

import Foundation
@testable import WeatherApplication

class MockWeatherApiService<T>: WeatherAPIServiceDelegate {
    
    var result: Result<T, DataError>!
    
    func getWeatherData<T: Codable>(modelType: T.Type, type: EndPointAPIType, queryItems: [URLQueryItem], completion: @escaping Handler<T>) {
        completion(result as! Result<T, DataError>)
    }
    
    func weather() -> WeatherResponse? {
        do {
            guard let weatherData = weatherData else {
                return nil
            }
            return try JSONDecoder().decode(WeatherResponse.self, from: weatherData)
        } catch {
            return nil
        }
    }
    
    func forecast() -> ForecastResponse? {
        do {
            guard let forecastData = forecastData else {
                return nil
            }
            return try JSONDecoder().decode(ForecastResponse.self, from: forecastData)
        } catch {
            return nil
        }
    }
}
