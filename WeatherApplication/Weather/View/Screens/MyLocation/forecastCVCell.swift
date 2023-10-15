//
//  forecastCVCell.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 10/10/23.
//

import UIKit

class forecastCVCell: UICollectionViewCell {
    let cellVMInst: CellViewModel = CellViewModel()
    let imgWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.applyShadow()
        return imageView
    }()
    let lblTime: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .robotoSlabMedium(size: 12)
        lbl.applyShadow()
        return lbl
    }()
    let lblTemp: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .robotoSlabMedium(size: 17)
        lbl.applyShadow()
        return lbl
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
    
    func setupCellProperty() {
        self.layer.cornerRadius = 30
        self.backgroundColor = UIColor(red: 0.656, green: 0.706, blue: 0.879, alpha: 1)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func setupUI() {
        self.addSubview(imgWeather)
        self.addSubview(lblTime)
        self.addSubview(lblTemp)
    }
    
    func setupConstraints() {
        imgWeather.width(75)
        imgWeather.edgesToSuperview(excluding: .right, insets: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0))
        lblTime.height(16)
        lblTime.top(to: self, offset: 27)
        lblTime.leftToRight(of: imgWeather, offset: 13)
        lblTemp.width(75)
        lblTemp.topToBottom(of: lblTime, offset: 5)
        lblTemp.bottom(to: self, offset: -15)
        lblTemp.leftToRight(of: imgWeather, offset: 13)
    }
    
    func configureForecastCellDetails(_ data: List) {
        imgWeather.image = UIImage(named: "\(data.weather[0].icon.dropLast())")
        lblTemp.text = "\(data.main.temp)c"
        lblTime.text = cellVMInst.formatDateto12Hrs(date: data.dt_txt)
    }
    
    func configureDefaultDetails() {
        imgWeather.setImage(with: "\(Constant.URL.weatherImageUrl)10d@2x.png")
        lblTime.text = "10:00 pm"
        lblTemp.text = "10 c"
    }
}