//
//  MockApiTest.swift
//  WeatherApplicationTests
//
//  Created by Jaydip Parmar on 15/10/23.
//

import XCTest
@testable import WeatherApplication

final class MockApiTest: XCTestCase {
    
    var viewModel: WeatherViewModel!
    var mockService: MockWeatherApiService!
    
    override func setUp() {
        super.setUp()
        mockService = MockWeatherApiService()
        viewModel = WeatherViewModel(weatherApiService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func test_WeatherAPIFailure() {
        //Arrange
        mockService.result = .failure(.invalidData)
        //ACT
        viewModel.getWeatherData()
        //ASSERT
        XCTAssertNil(viewModel.weatherData, "Weather Data is not nil")
    }
    
    func test_WeatherAPISuccess() {
        // Arrange
        guard let weather = mockService.weather() else { return }
        mockService.result = .success(weather)

        // Act
        viewModel.getWeatherData()

        // Assert
        XCTAssertNotNil(viewModel.weatherData)
    }
    
    func test_formatDate() {
        //Arrange
        let dt: Int = 1697372615
        //ACT
        let result = viewModel.formatDate(dt: dt)
        //Assert
        XCTAssertEqual(result, "October 15, 2023", "Both string should be equal")
    }
}
