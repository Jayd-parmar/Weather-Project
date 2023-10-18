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
    private let clblTemp: UILabel = {
        let label = UILabel()
        label.textColor = Theme.black
        label.font = .robotoSlabMedium(size: 20)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let cimgWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.applyShadow()
        return imageView
    }()
    private let lblCity: UILabel = {
        let label = UILabel()
        label.textColor = Theme.black
        label.font = .robotoSlabMedium(size: 20)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblDescWeather: UILabel = {
       let label = UILabel()
        label.textColor = Theme.black
        label.font = .robotoSlabLight(size: 18)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellProperty()
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellProperty() {
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = false
        self.layer.shadowColor = Theme.shadowBlack.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    private func setupUI() {
        let componentArray = [clblTemp, cimgWeather, lblDescWeather, lblCity]
        for component in componentArray {
            self.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        constraintsForTemp()
        constraintsForImgWeather()
        constraintsForDescWeather()
        constraintForCity()
    }
    
    private func constraintsForTemp() {
        clblTemp.height(26)
        clblTemp.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 22, left: 8, bottom: 0, right: 8))
    }
    
    private func constraintsForImgWeather() {
        cimgWeather.height(80)
        cimgWeather.topToBottom(of: clblTemp, offset: 1)
        cimgWeather.edgesToSuperview(excluding: [.top, .bottom], insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    private func constraintsForDescWeather() {
        lblDescWeather.height(24)
        lblDescWeather.topToBottom(of: cimgWeather, offset: 1)
        lblDescWeather.edgesToSuperview(excluding: [.top, .bottom], insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        lblDescWeather.text = "cloudy"
    }
    
    private func constraintForCity() {
        lblCity.topToBottom(of: lblDescWeather, offset: 1)
        lblCity.edgesToSuperview(excluding: [.top], insets: UIEdgeInsets(top: 0, left: 8, bottom: 22, right: 8))
    }
    
    func configurationLocationCellDetails(_ data: SearchWeather) {
        clblTemp.text = "\(data.temp)c"
        cimgWeather.image = UIImage(named: data.image!)
        lblDescWeather.text = data.weatherdesc
        lblCity.text = data.city
    }
}
