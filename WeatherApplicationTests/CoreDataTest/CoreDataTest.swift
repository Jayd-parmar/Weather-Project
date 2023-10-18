//
//  CoreDataTest.swift
//  WeatherApplicationTests
//
//  Created by Jaydip Parmar on 17/10/23.
//

import XCTest
@testable import WeatherApplication


final class CoreDataTest: XCTestCase {

    var viewModel: CoreDataViewModel!
    override func setUp() {
        super.setUp()
        viewModel = CoreDataViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_addWeatherLocation() {
        let coreData = CoreDataModel(id: "1", temp: 12.3, city: "Mumbai", image: "01", weatherDesc: "Cloudy")
        let weather = viewModel.addWeather(data: coreData)
        
        XCTAssertNotNil(weather, "Weather should not be nil")
    }
    
    func test_updateWeatherLocation() {
        let coreData = CoreDataModel(id: "1", temp: 12.3, city: "Mumbai", image: "01", weatherDesc: "Cloudy")
        var weather = viewModel.addWeather(data: coreData)
        weather!.temp = 10.0
        weather!.city = "New york"
        
        let updateWeather = viewModel.updateWeather(data: weather!)
        
        XCTAssertTrue(weather?.id == updateWeather?.id)
        XCTAssertTrue(updateWeather?.temp == 10.0)
        XCTAssertTrue(updateWeather?.city == "New york")
    }
    
    func test_fetchWeatherLocation() {
        let coreData = CoreDataModel(id: "1", temp: 12.3, city: "Mumbai", image: "01", weatherDesc: "Cloudy")
        let coreData1 = CoreDataModel(id: "1", temp: 12.3, city: "Mumbai", image: "01", weatherDesc: "Cloudy")
        let weather = viewModel.addWeather(data: coreData)
        let weather1 = viewModel.addWeather(data: coreData1)
        
        let weatherData = viewModel.fetchWeather()
        
        XCTAssertTrue(!weatherData!.isEmpty)
    }
    
    func test_getByID() {
        let coreData = CoreDataModel(id: "1", temp: 12.3, city: "Mumbai", image: "01", weatherDesc: "Cloudy")
        let weather = viewModel.addWeather(data: coreData)
        let found = viewModel.getById(id: (weather?.id)!)
        
        XCTAssertTrue(found)
    }
}
