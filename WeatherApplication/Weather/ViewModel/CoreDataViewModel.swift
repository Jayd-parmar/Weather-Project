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
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    func addWeather(id: String, temp: Double, city: String, image: String, weatherDesc: String) -> SearchWeather? {
        let weather = SearchWeather(context: context!)
        weather.temp = temp
        weather.city = city
        weather.image = image
        weather.weatherdesc = weatherDesc
        weather.id = id
        do {
            try context!.save()
            return weather
        } catch {
            print("fatalError in adding weather city")
        }
        return nil
    }
    
    func fetchWeather() -> [SearchWeather]? {
        do {
            return try context!.fetch(SearchWeather.fetchRequest())
        } catch {
            print("data isn't fetched")
        }
        return nil
    }
    
    func updateWeather(id: String, temp: Double, city: String, image: String, weatherDesc: String)-> SearchWeather? {
        let fetchRequest = SearchWeather.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let results = try context!.fetch(fetchRequest)
            guard let weatherToUpdate = results.first else { return nil}
            weatherToUpdate.id = id
            weatherToUpdate.temp = temp
            weatherToUpdate.city = city
            weatherToUpdate.image = image
            weatherToUpdate.weatherdesc = weatherDesc
            try context!.save()
            return weatherToUpdate
        } catch {
            print("fatal error while fetching the request of id")
        }
        return nil
    }
    
    func getById(id: String) -> Bool {
        let fetchRequest = SearchWeather.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        if ((try? context!.fetch(fetchRequest).first) != nil) {
            return true
        }
        return false
    }
}
