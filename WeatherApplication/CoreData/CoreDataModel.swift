//
//  CoreDataModel.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 17/10/23.
//
//
import Foundation

struct CoreDataModel {
    var id: String
    var temp: Double
    var city: String
    var image: String
    var weatherDesc: String
}

extension CoreDataModel {
    init(from searchWeather: SearchWeather) {
        self.id = searchWeather.id ?? "01"
        self.temp = searchWeather.temp
        self.city = searchWeather.city ?? "Mumbai"
        self.image = searchWeather.image ?? "01"
        self.weatherDesc = searchWeather.weatherdesc ?? "Cloudy"
    }
}
