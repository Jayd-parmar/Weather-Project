//
//  ResultCVCell.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 10/10/23.
//

import UIKit
import TinyConstraints

class ResultCVCell: UICollectionViewCell {
    
    let clblTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let cimgWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let lblCity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellProperty()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellProperty() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
    }
    
    func setupUI() {
        self.addSubview(clblTemp)
        self.addSubview(cimgWeather)
        self.addSubview(lblCity)
        setupConstraints()
    }
    
    func setupConstraints() {
        clblTemp.height(26)
        clblTemp.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 22, left: 8, bottom: 0, right: 8))
        cimgWeather.topToBottom(of: clblTemp, offset: 5)
        cimgWeather.edgesToSuperview(excluding: [.top, .bottom], insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        lblCity.height(24)
        lblCity.topToBottom(of: cimgWeather, offset: 5)
        lblCity.edgesToSuperview(excluding: [.top], insets: UIEdgeInsets(top: 0, left: 8, bottom: 40, right: 8))
    }
    
    func configurationLocationCellDetails(_ data: WeatherResponse) {
        clblTemp.text = "\(data.main.temp)c"
        cimgWeather.setImage(with: "\(Constant.URL.weatherImageUrl)\(data.weather[0].icon)@2x.png")
        lblCity.text = "\(data.name), \(data.sys.country)"
    }
}
