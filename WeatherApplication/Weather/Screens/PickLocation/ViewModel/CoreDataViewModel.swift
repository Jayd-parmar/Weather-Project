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
    
    func addWeather(data: CoreDataModel) -> SearchWeather? {
        return coreDataService.addWeather(data: data)
    }
    
    func fetchWeather() -> [SearchWeather]? {
        return coreDataService.fetchWeather()
    }
    
    func updateWeather(data: CoreDataModel)-> SearchWeather? {
        return coreDataService.updateWeather(data: data)
    }
    
    func getById(id: String) -> Bool {
        return coreDataService.getById(id: id)
    }
}
