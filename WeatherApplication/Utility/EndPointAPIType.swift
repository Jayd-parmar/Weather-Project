//
//  EndPointAPIType.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 08/10/23.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
}

protocol EndPointAPIType {
    var path: String { get }
    var url: String? { get }
    var methods: HttpMethod { get }
    var headers: [String: String]? { get }
}

enum EndPointItems {
    case weather
    case forecast
    case location
}

extension EndPointItems: EndPointAPIType {

    var headers: [String : String]? {
        return APIManager.commonHeaders
    }
    var path: String {
        switch self {
        case .weather:
            return "weather"
        case .forecast:
            return "forecast"
        case .location:
            return "weather"
        }
    }
    var url: String? {
        return "\(Constant.URL.apiBaseUrl)\(path)"
    }
    var methods: HttpMethod {
        return .get
    }
}
