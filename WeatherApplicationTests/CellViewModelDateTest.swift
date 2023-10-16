//
//  CellViewModelDateTest.swift
//  WeatherApplicationTests
//
//  Created by Jaydip Parmar on 16/10/23.
//

import XCTest
@testable import WeatherApplication

final class CellViewModelDateTest: XCTestCase {
    
    var viewModel: CellViewModel!
    override func setUp() {
        super.setUp()
        viewModel = CellViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_formatDate12Hrs() {
        let date: String = "2023-10-21 03:00:00"
        
        let result = viewModel.formatDateto12Hrs(date: date)
        
        XCTAssertEqual(result, "3:00 AM", "both should be equal")
    }
    
    func test_formatToDay() {
        let date: String = "2023-10-21 03:00:00"
        
        let result = viewModel.formatDateToDay(date: date)
        
        XCTAssertEqual(result, "Saturday", "both should be equal")
    }
    
    func test_formatMonthandDay() {
        let date: String = "2023-10-21 03:00:00"
        
        let result = viewModel.formatDateToMonthAndDay(date: date)
        
        XCTAssertEqual(result, "Oct 21", "both should be equal")
    }
}
