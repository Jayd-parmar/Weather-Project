//
//  ForecastViewModel.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 09/10/23.
//

import Foundation

class ForecastViewModel {
    
    var eventHandler: ((Event) -> Void)?
    var forecastData: ForecastResponse?
    var lat: Double? = 0.0
    var lon: Double? = 0.0
    private let weatherApiService: WeatherAPIServiceDelegate
    var queryItems: [URLQueryItem]? = nil
    
    init(weatherApiService: WeatherAPIServiceDelegate = WeatherApiService()) {
        self.weatherApiService = weatherApiService
    }
    
    func getWeatherData() {
        addQueryParams()
        self.eventHandler?(.loading)
        weatherApiService.getWeatherData(modelType: ForecastResponse.self,
                                          type: EndPointItems.forecast, queryItems: queryItems!
        ) { response in
            self.eventHandler?(.stopLoading)
                switch response {
                case .success(let forecast):
                    self.forecastData = forecast
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
            }
        }
    }
    
    private func addQueryParams() {
        queryItems = [
            URLQueryItem(name: "lat", value: "\(self.lat!)"),
            URLQueryItem(name: "lon", value: "\(self.lon!)"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: Constant.appid)
        ]
    }
}
