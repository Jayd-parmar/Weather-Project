//
//  WeatherService.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 15/10/23.
//

import Foundation

protocol WeatherAPIServiceDelegate {
    func getWeatherData<T: Codable>(
        modelType: T.Type,
        type: EndPointAPIType,
        completion: @escaping Handler<T>
    )
    
    func getForecastData<T: Codable>(
        modelType: T.Type,
        type: EndPointAPIType,
        completion: @escaping Handler<T>
    )
}

class WeatherApiService: WeatherAPIServiceDelegate {
    func getWeatherData<T: Codable>(modelType: T.Type, type: EndPointAPIType, completion: @escaping Handler<T>) {
        APIManager.shared.request(modelType: modelType, type: type, completion: completion)
    }
    
    func getForecastData<T: Codable>(modelType: T.Type, type: EndPointAPIType, completion: @escaping Handler<T>) {
        APIManager.shared.request(modelType: modelType, type: type, completion: completion)
    }
}