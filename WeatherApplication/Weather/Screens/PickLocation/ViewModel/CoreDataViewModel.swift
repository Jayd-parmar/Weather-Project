//
//  CoreDataViewModel.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 16/10/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataViewModel {
    
    private let coreDataService: CoreDataServiceDelegate
    
    init(coreDataService: CoreDataServiceDelegate = CoreDataService()) {
        self.coreDataService = coreDataService
    }
    
    func addWeather(id: String, temp: Double, city: String, image: String, weatherDesc: String) -> SearchWeather? {
        return coreDataService.addWeather(id: id, temp: temp, city: city, image: image, weatherDesc: weatherDesc)
    }
    
    func fetchWeather() -> [SearchWeather]? {
        return coreDataService.fetchWeather()
    }
    
    func updateWeather(id: String, temp: Double, city: String, image: String, weatherDesc: String)-> SearchWeather? {
        return coreDataService.updateWeather(id: id, temp: temp, city: city, image: image, weatherDesc: weatherDesc)
    }
    
    func getById(id: String) -> Bool {
        return coreDataService.getById(id: id)
    }
}
