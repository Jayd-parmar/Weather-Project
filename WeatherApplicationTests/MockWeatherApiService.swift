//
//  MockWeatherApiService.swift
//  WeatherApplicationTests
//
//  Created by Jaydip Parmar on 15/10/23.
//

import Foundation
@testable import WeatherApplication

class MockWeatherApiService: WeatherAPIServiceDelegate {
    
    var result: Result<WeatherResponse, DataError>!
    var resultForecast: Result<ForecastResponse, DataError>!
    
    func getWeatherData<T: Codable>(modelType: T.Type, type: EndPointAPIType, queryItems: [URLQueryItem], completion: @escaping Handler<T>) {
        completion(result as! Result<T, DataError>)
    }
    
    func getForecastData<T>(modelType: T.Type, type: WeatherApplication.EndPointAPIType, queryItems: [URLQueryItem], completion: @escaping WeatherApplication.Handler<T>) where T : Decodable, T : Encodable {
        completion(resultForecast as! Result<T, DataError>)
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
