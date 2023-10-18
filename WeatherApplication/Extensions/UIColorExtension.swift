//
//  UIColorExtension.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 18/10/23.
//

import Foundation
import UIKit

extension UIColor {
    
    static func setColor(darkColor: UIColor, lightColor: UIColor) -> UIColor{
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .light ? lightColor : darkColor
            }
        } else {
            return lightColor
        }
    }
}
