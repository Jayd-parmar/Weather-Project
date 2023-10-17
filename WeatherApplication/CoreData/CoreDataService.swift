//
//  CoreDataService.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 17/10/23.
//

import Foundation

class CoreDataService: CoreDataServiceDelegate {
    
    func addWeather(data: CoreDataModel) -> SearchWeather? {
        let weather = SearchWeather(context: Context.context!)
        weather.temp = data.temp
        weather.city = data.city
        weather.image = data.image
        weather.weatherdesc = data.weatherDesc
        weather.id = data.id
        do {
            try Context.context!.save()
            return weather
        } catch {
            print("fatalError in adding weather city")
        }
        return nil
    }
    
    func fetchWeather() -> [SearchWeather]? {
        do {
            return try Context.context!.fetch(SearchWeather.fetchRequest())
        } catch {
            print("data isn't fetched")
        }
        return nil
    }
    
    func updateWeather(data: CoreDataModel) -> SearchWeather? {
        let fetchRequest = SearchWeather.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", data.id)
        do {
            let results = try Context.context!.fetch(fetchRequest)
            guard let weatherToUpdate = results.first else { return nil}
            weatherToUpdate.id = data.id
            weatherToUpdate.temp = data.temp
            weatherToUpdate.city = data.city
            weatherToUpdate.image = data.image
            weatherToUpdate.weatherdesc = data.weatherDesc
            try Context.context!.save()
            return weatherToUpdate
        } catch {
            print("fatal error while fetching the request of id")
        }
        return nil
    }
    
    func getById(id: String) -> Bool {
        let fetchRequest = SearchWeather.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        if ((try? Context.context!.fetch(fetchRequest).first) != nil) {
            return true
        }
        return false
    }
}

protocol CoreDataServiceDelegate {
    
    func addWeather(data: CoreDataModel) -> SearchWeather?
    
    func updateWeather(data: CoreDataModel)-> SearchWeather?
    
    func getById(id: String) -> Bool
    
    func fetchWeather() -> [SearchWeather]?
}
