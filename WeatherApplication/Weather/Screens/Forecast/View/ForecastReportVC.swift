//
//  ForecastReportVC.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 08/10/23.
//

import UIKit

class ForecastReportVC: UIViewController {

    private let lblForecast: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.white
        label.font = .robotoSlabMedium(size: 30)
        label.textAlignment = .center
        label.text = "Forecast Report"
        label.applyShadow()
        return label
    }()
    private let contentView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.setColor(darkColor: Theme.darkGrayishBlue, lightColor: Theme.lightGrayishBlue)
        return cv
    }()
    private let forecastCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 350, height: 84)
        layout.minimumLineSpacing = 20
        let cv = UICollectionView( frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.setColor(darkColor: Theme.darkGrayishBlue, lightColor: Theme.lightGrayishBlue)
        cv.showsVerticalScrollIndicator = false
        cv.register(ForecastReportCVCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    var forecastData: ForecastResponse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setUpUICollectionView()
    }
    
    private func setupUI() {
        view.addSubview(contentView)
        contentView.addSubview(lblForecast)
    }
    
    private func setupConstraints() {
        contentView.edgesToSuperview()
        lblForecast.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 100, left: 10, bottom: 0, right: 10))
    }
    
    private func setUpUICollectionView() {
        contentView.addSubview(forecastCV)
        forecastCV.dataSource = self
        constraintsForForecastCV()
    }
    
    private func constraintsForForecastCV() {
        forecastCV.topToBottom(of: lblForecast, offset: 31)
        forecastCV.left(to: contentView, offset: 15)
        forecastCV.right(to: contentView, offset: -15)
        forecastCV.bottom(to: contentView, offset: 0)
    }
}

extension ForecastReportVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (forecastData?.list.count) ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ForecastReportCVCell
        cell?.configureForecastCellDetails((forecastData?.list[indexPath.row])!)
        return cell!
    }
}
