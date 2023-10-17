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
        let weather = viewModel.addWeather(
            id: "1", temp: 12.3, city: "Mumbai", image: "01", weatherDesc: "Cloudy")
        
        XCTAssertNotNil(weather, "Weather should not be nil")
    }
    
    func test_updateWeatherLocation() {
        let weather = viewModel.addWeather(id: "1", temp: 0.0, city: "", image: "", weatherDesc: "")
        weather!.temp = 10.0
        weather!.city = "New york"
        
        let updateWeather = viewModel.updateWeather(id: (weather?.id)!, temp: weather!.temp, city: (weather?.city)!, image: (weather?.image)!, weatherDesc: (weather?.weatherdesc)!)
        
        XCTAssertTrue(weather?.id == updateWeather?.id)
        XCTAssertTrue(updateWeather?.temp == 10.0)
        XCTAssertTrue(updateWeather?.city == "New york")
    }
    
    func test_fetchWeatherLocation() {
        let weather = viewModel.addWeather(id: "12", temp: 10.0, city: "Mumbai", image: "02", weatherDesc: "Cloudy")
        let weather1 = viewModel.addWeather(id: "13", temp: 20.0, city: "Pune", image: "03", weatherDesc: "Drizzle")
        
        let weatherData = viewModel.fetchWeather()
        
        XCTAssertTrue(!weatherData!.isEmpty)
    }
    
    func test_getByID() {
        let weather = viewModel.addWeather(id: "1", temp: 30.0, city: "Botad", image: "04", weatherDesc: "Rainy")
        let found = viewModel.getById(id: (weather?.id)!)
        
        XCTAssertTrue(found)
    }
}
