//
//  Enum.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 17/10/23.
//

import Foundation

enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
}

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}
