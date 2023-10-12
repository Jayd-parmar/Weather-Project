//
//  ForecastReportVC.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 08/10/23.
//

import UIKit

class ForecastReportVC: UIViewController {

    let lblForecast: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Forecast Report"
        label.applyShadow()
        return label
    }()
    
    let contentView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(red: 0.51, green: 0.549, blue: 0.682, alpha: 1)
        return cv
    }()
    var forecastCV: UICollectionView!
    var forecastData: ForecastResponse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setUpUICollectionView()
    }
    
    func setupUI() {
        view.addSubview(contentView)
        contentView.addSubview(lblForecast)
    }
    
    func setupConstraints() {
        contentView.edgesToSuperview()
        lblForecast.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 100, left: 10, bottom: 0, right: 10))
    }
    
    func setUpUICollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 350, height: 84)
        layout.minimumLineSpacing = 20

        forecastCV = UICollectionView( frame: .zero, collectionViewLayout: layout)
        forecastCV.translatesAutoresizingMaskIntoConstraints = false
        forecastCV.delegate = self
        forecastCV.dataSource = self
        forecastCV.backgroundColor = UIColor(red: 0.51, green: 0.549, blue: 0.682, alpha: 1)
        forecastCV.showsVerticalScrollIndicator = false
        forecastCV.register(ForecastReportCVCell.self, forCellWithReuseIdentifier: "cell")
        contentView.addSubview(forecastCV)
        
        forecastCV.topToBottom(of: lblForecast, offset: 31)
        forecastCV.left(to: contentView, offset: 15)
        forecastCV.right(to: contentView, offset: -15)
        forecastCV.bottom(to: contentView, offset: 0)
    }
}

extension ForecastReportVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (forecastData?.list.count) ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ForecastReportCVCell
        cell?.configureForecastCellDetails((forecastData?.list[indexPath.row])!)
        return cell!
    }
}
