//
//  ApiManager.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 08/10/23.
//

import Foundation

typealias Handler<T> = (Result<T, DataError>) -> Void

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

final class APIManager {
    static let shared = APIManager()
    private let appid = "3f12be7cfb02c3ddcdc448d07932bc07"
    static var lat: Double? = 0.0
    static var lon: Double? = 0.0
    static var searchCity: String? = nil
    private init() {}
    
    func request<T: Codable>(
        modelType: T.Type,    // Response
        type: EndPointAPIType,
        completion: @escaping Handler<T>
    ) {
        guard let strURL = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        // For queryParams
        var queryItems: [URLQueryItem]? = nil
        if type.apiType == "weather" || type.apiType == "forecast" {
            queryItems = [URLQueryItem(name: "lat", value: "\(APIManager.lat!)"), URLQueryItem(name: "lon", value: "\(APIManager.lon!)"),URLQueryItem(name: "units", value: "metric"),URLQueryItem(name: "appid", value: appid)]
        } else if type.apiType == "location" {
            queryItems = [URLQueryItem(name: "q", value: "\(APIManager.searchCity!)"),URLQueryItem(name: "units", value: "metric"),URLQueryItem(name: "appid", value: appid)]
        }
        
        var urlComps = URLComponents(string: strURL)
        urlComps?.queryItems = queryItems
        var request = URLRequest(url: (urlComps?.url)!)
        request.httpMethod = type.methods.rawValue
        request.allHTTPHeaderFields = type.headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let response = try JSONDecoder().decode(modelType, from: data)
                completion(.success(response))
            } catch {
                print(error)
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
    
}
