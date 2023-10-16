//
//  MockForecastAPITest.swift
//  WeatherApplicationTests
//
//  Created by Jaydip Parmar on 16/10/23.
//

import XCTest
@testable import WeatherApplication

final class MockForecastAPITest: XCTestCase {
    
    var viewModel: ForecastViewModel!
    var mockService: MockWeatherApiService!
    
    override func setUp() {
        super.setUp()
        mockService = MockWeatherApiService()
        viewModel = ForecastViewModel(weatherApiService: mockService)
    }

    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_ForecastAPIFailure() {
        //Arrange
        mockService.resultForecast = .failure(.invalidData)
        //ACT
        viewModel.getForecastData()
        //ASSERT
        XCTAssertNil(viewModel.forecastData, "Forecast Data is not nil")
    }
    
    func test_WeatherAPISuccess() {
        // Arrange
        guard let forecast = mockService.forecast() else { return }
        mockService.resultForecast = .success(forecast)

        // Act
        viewModel.getForecastData()

        // Assert
        XCTAssertNotNil(viewModel.forecastData)
    }
}
