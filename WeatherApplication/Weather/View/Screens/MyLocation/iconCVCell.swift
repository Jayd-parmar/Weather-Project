//
//  iconCVCell.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 13/10/23.
//

import UIKit

class iconCVCell: UICollectionViewCell {
    
    private var imgWeather : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "01")
        return imageView
    }()
    private var lblWeather : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        label.applyShadow()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(imgWeather)
        self.addSubview(lblWeather)
    }
    
    func setupConstraints() {
        imgWeather.size(CGSize(width: 60, height: 60))
        imgWeather.center(in: self)
        imgWeather.top(to: self)
        lblWeather.height(20)
        lblWeather.topToBottom(of: imgWeather)
        lblWeather.centerX(to: imgWeather)
    }
    
    func configrationCellDetails(_ image: String, _ label: String) {
        imgWeather.image = UIImage(named: image)
        lblWeather.text = label
    }
}
