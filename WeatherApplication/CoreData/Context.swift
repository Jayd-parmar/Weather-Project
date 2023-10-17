//
//  Context.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 17/10/23.
//

import Foundation
import UIKit

enum Context {
    static let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
}
