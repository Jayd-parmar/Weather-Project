//
//  ForecastReportCVCell.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 11/10/23.
//

import UIKit

class ForecastReportCVCell: UICollectionViewCell {
    let cellVMInst: CellViewModel = CellViewModel()
    private let imgWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.applyShadow()
        return imageView
    }()
    private let lblDate: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = Theme.white
        lbl.font = .robotoSlabMedium(size: 14)
        lbl.textAlignment = .center
        lbl.applyShadow()
        return lbl
    }()
    private let lblTime: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = Theme.white
        lbl.font = .robotoSlabLight(size: 13)
        lbl.textAlignment = .center
        lbl.applyShadow()
        return lbl
    }()
    private let lblTemp: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = Theme.white
        lbl.font = .robotoSlabMedium(size: 36)
        lbl.numberOfLines = 1
        lbl.applyShadow()
        return lbl
    }()
    private let containerView: UIView = {
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
    
    private func setupCellProperty() {
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor.setColor(darkColor: Theme.darkPeriWinkleBlue, lightColor: Theme.lightPeriWinkleBlue)
        self.layer.masksToBounds = false
        self.layer.shadowColor = Theme.shadowBlack.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    private func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(lblDate)
        containerView.addSubview(lblTime)
        self.addSubview(lblTemp)
        self.addSubview(imgWeather)
    }
    
    private func setupUIConstraints() {
       constraintsForContainerView()
        constraintsForDate()
        constraintsForTemp()
        constraintsForTime()
        constraintsForImgWeather()
    }
    
    private func constraintsForContainerView() {
        containerView.width(90)
        containerView.edgesToSuperview(excluding: .right, insets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 0))
    }
    
    private func constraintsForDate() {
        lblDate.edgesToSuperview(excluding: [.bottom], insets: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))
    }
    
    private func constraintsForTemp() {
        lblTemp.leftToRight(of: containerView, offset: 20)
        lblTemp.center(in: self)
    }
    
    private func constraintsForTime() {
        lblTime.topToBottom(of: lblDate, offset: 1)
        lblTime.centerX(to: lblDate)
       
    }
    
    private func constraintsForImgWeather() {
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
