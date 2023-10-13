//
//  ForecastReportCVCell.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 11/10/23.
//

import UIKit

class ForecastReportCVCell: UICollectionViewCell {
    let cellVMInst: CellViewModel = CellViewModel()
    let imgWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.applyShadow()
        return imageView
    }()
    let lblDate: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = .robotoSlabMedium(size: 14)
        lbl.textAlignment = .center
        lbl.applyShadow()
        return lbl
    }()
    let lblTime: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = .robotoSlabLight(size: 13)
        lbl.textAlignment = .center
        lbl.applyShadow()
        return lbl
    }()
    let lblTemp: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = .robotoSlabMedium(size: 36)
        lbl.numberOfLines = 1
        lbl.applyShadow()
        return lbl
    }()
    let containerView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
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
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(lblDate)
        containerView.addSubview(lblTime)
        self.addSubview(lblTemp)
        self.addSubview(imgWeather)
    }
    
    func setupUIConstraints() {
        containerView.width(90)
        containerView.edgesToSuperview(excluding: .right, insets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 0))
        lblDate.edgesToSuperview(excluding: [.bottom], insets: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))
        lblTime.topToBottom(of: lblDate, offset: 1)
        lblTime.centerX(to: lblDate)
        lblTemp.leftToRight(of: containerView, offset: 20)
        lblTemp.center(in: self)
        imgWeather.width(80)
        imgWeather.right(to: self, offset: -15)
        imgWeather.edgesToSuperview(excluding: [.left, .right], insets: UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0))
    }
    
    func configureForecastCellDetails(_ data: List) {
        lblDate.text = "\(cellVMInst.formatDateToDay(date: data.dt_txt))"
        lblTime.text = "\(cellVMInst.formatDateToMonthAndDay(date: data.dt_txt))"
        let temp = String(format: "%.1f", data.main.temp)
        lblTemp.text = "\(temp)c"
        imgWeather.image = UIImage(named: "\(data.weather[0].icon.dropLast())")
    }
}
