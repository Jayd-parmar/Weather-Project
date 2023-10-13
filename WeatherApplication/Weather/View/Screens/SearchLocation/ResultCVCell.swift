//
//  ResultCVCell.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 10/10/23.
//

import UIKit
import TinyConstraints

class ResultCVCell: UICollectionViewCell {
    //MARK: -Variable
    let clblTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .robotoSlabMedium(size: 20)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    
    let cimgWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.applyShadow()
        return imageView
    }()
    
    let lblCity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .robotoSlabMedium(size: 20)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    
    let lblDescWeather: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .robotoSlabLight(size: 18)
        label.textAlignment = .center
        label.applyShadow()
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
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func setupUI() {
        self.addSubview(clblTemp)
        self.addSubview(cimgWeather)
        self.addSubview(lblDescWeather)
        self.addSubview(lblCity)
        setupConstraints()
    }
    
    func setupConstraints() {
        clblTemp.height(26)
        clblTemp.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 22, left: 8, bottom: 0, right: 8))
        cimgWeather.height(80)
        cimgWeather.topToBottom(of: clblTemp, offset: 1)
        cimgWeather.edgesToSuperview(excluding: [.top, .bottom], insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        lblDescWeather.height(24)
        lblDescWeather.topToBottom(of: cimgWeather, offset: 1)
        lblDescWeather.edgesToSuperview(excluding: [.top, .bottom], insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        lblDescWeather.text = "cloudy"
        lblCity.topToBottom(of: lblDescWeather, offset: 1)
        lblCity.edgesToSuperview(excluding: [.top], insets: UIEdgeInsets(top: 0, left: 8, bottom: 22, right: 8))
    }
    
    func configurationLocationCellDetails(_ data: WeatherResponse) {
        clblTemp.text = "\(data.main.temp)c"
        cimgWeather.image = UIImage(named: "\(data.weather[0].icon.dropLast())")
        lblDescWeather.text = "\(data.weather[0].main)"
        lblCity.text = "\(data.name), \(data.sys.country)"
    }
}
