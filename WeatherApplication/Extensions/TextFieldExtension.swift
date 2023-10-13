//
//  TextFieldExtension.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 13/10/23.
//

import Foundation
import UIKit

extension UITextField {
    func setIcon(_ image: UIImage) {
       let iconView = UIImageView(frame:
                                    CGRect(x: 285, y: 5, width: 20, height: 20))
       iconView.image = image

       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 20, y: 0, width: 30, height: 30))
       iconContainerView.addSubview(iconView)
       leftView = iconContainerView
       leftViewMode = .always
    }
}
