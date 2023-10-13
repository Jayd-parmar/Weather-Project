//
//  LabelExtension.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 13/10/23.
//

import Foundation
import UIKit

extension UILabel {
    func applyShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
