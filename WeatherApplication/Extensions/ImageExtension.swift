//
//  ImageExtension.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 13/10/23.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func applyShadow() {
        self.layer.shadowColor = Theme.shadowBlack.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func setImage(with urlString: String) {
        guard let url = URL.init(string: urlString) else { return }
        let resource = KF.ImageResource(downloadURL: url)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
