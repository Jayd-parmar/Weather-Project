//
//  WeatherService.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 15/10/23.
//

import Foundation


class WeatherApiService: WeatherAPIServiceDelegate {
    
    func getWeatherData<T: Codable>(modelType: T.Type, type: EndPointAPIType, queryItems: [URLQueryItem], completion: @escaping Handler<T>) {
        APIManager.shared.request(modelType: modelType, type: type, queryItems: queryItems, completion: completion)
    }
}

protocol WeatherAPIServiceDelegate {
    func getWeatherData<T: Codable>(
        modelType: T.Type,
        type: EndPointAPIType,
        queryItems: [URLQueryItem],
        completion: @escaping Handler<T>
    )
}
