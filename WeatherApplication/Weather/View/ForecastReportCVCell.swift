//
//  ForecastReportCVCell.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 11/10/23.
//

import UIKit

class ForecastReportCVCell: UICollectionViewCell {
    let imgWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    let lblTime: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        return lbl
    }()
    let lblTemp: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 36.0)
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellProperty()
        setupUI()
        setupUIConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellProperty() {
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor(red: 0.656, green: 0.706, blue: 0.879, alpha: 1)
    }
    
    func setupUI() {
        self.addSubview(lblTime)
        self.addSubview(lblTemp)
        self.addSubview(imgWeather)
    }
    
    func setupUIConstraints() {
        lblTime.edgesToSuperview(excluding: .right, insets: UIEdgeInsets(top: 22, left: 20, bottom: 22, right: 0))
        lblTemp.leftToRight(of: lblTime, offset: 20)
        lblTemp.centerY(to: lblTime)
        imgWeather.leftToRight(of: lblTemp, offset: 20)
        imgWeather.centerY(to: lblTemp)
    }
    
    func configureForecastCellDetails(_ data: List) {
        lblTime.text = formateDate(date: data.dt_txt)
        lblTemp.text = "\(data.main.temp) c"
        imgWeather.setImage(with: "\(Constant.URL.weatherImageUrl)\(data.weather[0].icon)@2x.png")
    }
    
    func formateDate(date: String) -> String {
        let dateString = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return dateFormatter.string(from: date)
        }
        return "11-11-2023"
    }
}
