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
    
    func getWeatherData(search: String?) {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: WeatherResponse.self,
            type: (search != nil) ? EndPointItems.location : EndPointItems.weather
        ){ response in
            self.eventHandler?(.stopLoading)
                switch response {
                case .success(let weather):
                    (search != nil) ? (self.pickLocationData = weather) : (self.weatherData = weather)
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
        }
    }
}

enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
}
