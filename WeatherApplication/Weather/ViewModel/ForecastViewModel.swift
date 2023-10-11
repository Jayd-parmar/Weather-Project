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
    
    func getForecastData() {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: ForecastResponse.self,
            type: EndPointItems.forecast
        ){ response in
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
}
