//
//  WeatherViewModel.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 09/10/23.
//

import Foundation

class WeatherViewModel {
    
    var eventHandler: ((Event) -> Void)?
    var weatherData: WeatherResponse?
    var pickLocationData: WeatherResponse?
    var search: String? = nil
    var lat: Double? = 0.0
    var lon: Double? = 0.0
    let iconData: [(String, String)] = [
        ("01", "clear sky"),
        ("02", "few clouds"),
        ("03", "scattered clouds"),
        ("04", "broken clouds"),
        ("09", "shower rain"),
        ("10", "rain"),
        ("11", "thunderstorm"),
        ("13", "snow"),
        ("50", "mist")
    ]
    var queryItems: [URLQueryItem]? = nil
    private let weatherApiService: WeatherAPIServiceDelegate
    
    init(weatherApiService: WeatherAPIServiceDelegate = WeatherApiService()) {
        self.weatherApiService = weatherApiService
    }
    
    func getWeatherData() {
        addQueryParams()
        self.eventHandler?(.loading)
        weatherApiService.getWeatherData(modelType: WeatherResponse.self,
                                         type: (self.search != nil) ? EndPointItems.location : EndPointItems.weather, queryItems: queryItems!) { response in
            self.eventHandler?(.stopLoading)
                switch response {
                case .success(let weather):
                    (self.search != nil) ? (self.pickLocationData = weather) : (self.weatherData = weather)
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
            }
        }
    }
    
    func formatDate(dt: Int) -> String {
        let timestamp = TimeInterval(dt)
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    private func addQueryParams() {
        if self.search != nil {
            queryItems = [
                URLQueryItem(name: "q", value: search),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: Constant.appid)
            ]
        } else {
            queryItems = [
                URLQueryItem(name: "lat", value: "\(self.lat!)"),
                URLQueryItem(name: "lon", value: "\(self.lon!)"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: Constant.appid)
            ]
        }
    }
}
