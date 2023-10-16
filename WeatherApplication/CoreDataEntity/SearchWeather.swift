//
//  SearchWeather+CoreDataClass.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 16/10/23.
//
//

import Foundation
import CoreData

@objc(SearchWeather)
public class SearchWeather: NSManagedObject {

}

extension SearchWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchWeather> {
        return NSFetchRequest<SearchWeather>(entityName: "SearchWeather")
    }

    @NSManaged public var id: String?
    @NSManaged public var temp: Double
    @NSManaged public var city: String?
    @NSManaged public var weatherdesc: String?
    @NSManaged public var image: String?

}

extension SearchWeather : Identifiable {

}
