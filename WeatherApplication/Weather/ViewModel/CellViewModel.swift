//
//  CellViewModel.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 13/10/23.
//

import Foundation

class CellViewModel {
    func formatDateto12Hrs(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "h:mm a"
            dateFormatter.locale = Locale(identifier: "en_US")
            return dateFormatter.string(from: date)
        } else {
            return "10:00 PM"
        }
    }
    
    func formatDateToDay(date: String) -> String {
        let dateString = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.locale = Locale(identifier: "en_US")
            return dateFormatter.string(from: date)
        }
        return "Tuesday"
    }
    
    func formatDateToMonthAndDay(date: String) -> String {
        let dateString = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM dd"
            dateFormatter.locale = Locale(identifier: "en_US")
            return dateFormatter.string(from: date)
        }
        return "Oct 13"
    }
    
}
