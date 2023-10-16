//
//  MyLocationVC.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 08/10/23.
//

import UIKit
import CoreLocation
import TinyConstraints

class MyLocationVC: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - Variables
    var manager: CLLocationManager = CLLocationManager()
    var lat: Double = 0.0
    var lon: Double = 0.0
    let weatherVMInst = WeatherViewModel()
    let forecastVMInst = ForecastViewModel()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = UIColor(red: 0.51, green: 0.549, blue: 0.682, alpha: 1)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    private let contentView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    private let lblCity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .robotoSlabMedium(size: 30)
        label.applyShadow()
        return label
    }()
    private let lblDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .robotoSlabLight(size: 15)
        label.applyShadow()
        return label
    }()
    private let imgWeather: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.applyShadow()
        return image
    }()
    private let lblTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .robotoSlabMedium(size: 70)
        label.applyShadow()
        return label
    }()
    private let vwTemp: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    private let vwHumidity: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    private let vwWind: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    private let lblTmp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .robotoSlabLight(size: 15)
        label.text = "Temp"
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblValTmp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .robotoSlabMedium(size: 20)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblHmdty: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .robotoSlabLight(size: 15)
        label.text = "Humidity"
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblValHmdty: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .robotoSlabMedium(size: 20)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblWind: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoSlabLight(size: 15)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = "Wind"
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblValWind: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .robotoSlabMedium(size: 20)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblToday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Today"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .robotoSlabLight(size: 20)
        label.applyShadow()
        return label
    }()
    private let btnViewReport: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("View Report", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .robotoSlabLight(size: 20)
        btn.applyShadow()
        return btn
    }()
    private let iconCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 5, right: 13)
        layout.estimatedItemSize = CGSize(width: 86, height: 80)
        layout.minimumLineSpacing = 30
        
        let cv = UICollectionView( frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor =  UIColor(red: 0.469, green: 0.511, blue: 0.654, alpha: 1)
        cv.showsHorizontalScrollIndicator = false
        cv.clipsToBounds = false
        cv.register(iconCVCell.self, forCellWithReuseIdentifier: "cell")
        cv.applyShadow()
        return cv
    }()
    private let forecastCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 166, height: 85)
        layout.minimumLineSpacing = 20
        
        let cv = UICollectionView( frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(red: 0.51, green: 0.549, blue: 0.682, alpha: 1)
        cv.showsHorizontalScrollIndicator = false
        cv.clipsToBounds = false
        cv.register(forecastCVCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupUIConstraints()
        setUpdelegateDataSourceCV()
        observeEventWeather()
        observeEventForecast()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(iconCV)
        contentView.addSubview(lblCity)
        contentView.addSubview(lblDate)
        contentView.addSubview(imgWeather)
        contentView.addSubview(lblTemp)
        contentView.addSubview(vwTemp)
        contentView.addSubview(vwHumidity)
        contentView.addSubview(vwWind)
        vwTemp.addSubview(lblTmp)
        vwTemp.addSubview(lblValTmp)
        vwHumidity.addSubview(lblHmdty)
        vwHumidity.addSubview(lblValHmdty)
        vwWind.addSubview(lblWind)
        vwWind.addSubview(lblValWind)
        contentView.addSubview(lblToday)
        contentView.addSubview(btnViewReport)
        btnViewReport.addTarget(self, action: #selector(viewReportTapped), for: .touchUpInside)
        contentView.addSubview(forecastCV)
    }
    
    private func setupUIConstraints() {
        scrollView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height)
        scrollView.edgesToSuperview()
        contentView.width(view.bounds.width)
        contentView.height(view.bounds.height)
        contentView.edges(to: scrollView)
        
        iconCV.height(100)
        iconCV.edges(to: contentView, excluding: .bottom)
        
        lblCity.height(40)
        lblCity.centerX(to: contentView)
        lblCity.topToBottom(of: iconCV, offset: 23)
        
        lblDate.height(20)
        lblDate.centerX(to: contentView)
        lblDate.topToBottom(of: lblCity, offset: 3)
        
        imgWeather.width(155)
        imgWeather.height(155)
        imgWeather.centerX(to: contentView)
        imgWeather.topToBottom(of: lblDate, offset: 24)
        
        lblTemp.height(92)
        lblTemp.centerX(to: contentView)
        lblTemp.topToBottom(of: imgWeather)
        
        vwTemp.width(80)
        vwTemp.height(50)
        vwTemp.topToBottom(of: lblTemp, offset: 38)
        vwTemp.left(to: contentView, offset: 38)
        vwHumidity.width(80)
        vwHumidity.height(50)
        vwHumidity.leftToRight(of: vwTemp, offset: 60)
        vwHumidity.centerY(to: vwTemp)
        vwWind.width(80)
        vwWind.height(50)
        vwWind.leftToRight(of: vwHumidity, offset: 60)
        vwWind.centerY(to: vwHumidity)
        
        lblTmp.height(20)
        lblTmp.edges(to: vwTemp, excluding: .bottom, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        lblValTmp.centerX(to: lblTmp)
        lblValTmp.topToBottom(of: lblTmp)
        
        lblHmdty.height(20)
        lblHmdty.edges(to: vwHumidity, excluding: .bottom, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        lblValHmdty.topToBottom(of: lblTmp)
        lblValHmdty.centerX(to: lblHmdty)
        
        lblWind.height(20)
        lblWind.edges(to: vwWind, excluding: .bottom, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        lblValWind.centerX(to: lblWind)
        lblValWind.topToBottom(of: lblTmp)
        
        lblToday.left(to: contentView, offset: 24)
        lblToday.topToBottom(of: vwTemp, offset: 31)
        btnViewReport.topToBottom(of: vwWind, offset: 31)
        btnViewReport.right(to: contentView, offset: -21)
        
        forecastCV.topToBottom(of: btnViewReport, offset: 31)
        forecastCV.left(to: contentView, offset: 10)
        forecastCV.right(to: contentView, offset: 10)
        forecastCV.height(90)
    }
    
    private func setUpdelegateDataSourceCV() {
        iconCV.delegate = self
        iconCV.dataSource = self
        forecastCV.delegate = self
        forecastCV.dataSource = self
    }
    
    @objc func viewReportTapped() {
        let forecastReportVC = self.storyboard?.instantiateViewController(withIdentifier: "ForecastReportVC") as! ForecastReportVC
        forecastReportVC.forecastData = forecastVMInst.forecastData
        self.navigationController?.pushViewController(forecastReportVC, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else { return }
        lat = first.coordinate.latitude
        lon = first.coordinate.longitude
        APIManager.lat = lat
        APIManager.lon = lon
        weatherVMInst.getWeatherData()
        forecastVMInst.getForecastData()
    }
    
    private func observeEventWeather() {
        weatherVMInst.eventHandler = { [weak self] event in
            guard let self else { return }
            DispatchQueue.main.async {
                switch event {
                case .loading:
                    self.showIndicator()
                case .stopLoading:
                    self.dismissIndicator()
                case .dataLoaded:
                    self.configureWeatherDetails()
                case .error(_):
                    self.showToast(message: "Error while fetching the weather request", font: .systemFont(ofSize: 12.0))
                }
            }
        }
    }
    
    private func configureWeatherDetails() {
        guard let weather = weatherVMInst.weatherData else { return }
        lblCity.text = weather.name
        lblDate.text = weatherVMInst.formatDate(dt: weather.dt)
        lblTemp.text = "\(weather.main.temp)c"
        lblValTmp.text = "\(weather.main.temp)c"
        lblValHmdty.text = "\(weather.main.humidity)%"
        lblValWind.text = "\(weather.wind.speed) kmph"
        imgWeather.image = UIImage(named: "\(weather.weather[0].icon.dropLast())")
    }
    
    private func observeEventForecast() {
        forecastVMInst.eventHandler = { [weak self] event in
            guard let self else { return }
            DispatchQueue.main.async {
                switch event {
                case .loading:
                    self.showIndicator()
                case .stopLoading:
                    self.dismissIndicator()
                case .dataLoaded:
                    self.forecastCV.reloadData()
                case .error(_):
                    self.showToast(message: "Error while fetching the forecast request", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
}

extension MyLocationVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.iconCV:
            return weatherVMInst.iconData.count
        case self.forecastCV:
            return (forecastVMInst.forecastData?.list.count) ?? 5
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.iconCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? iconCVCell
            cell!.configrationCellDetails(weatherVMInst.iconData[indexPath.row].0, weatherVMInst.iconData[indexPath.row].1)
            return cell!
        case self.forecastCV:
            if let forecastData = forecastVMInst.forecastData?.list {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? forecastCVCell
                cell!.configureForecastCellDetails(forecastData[indexPath.row])
                return cell!
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? forecastCVCell
                cell!.configureDefaultDetails()
                return cell!
            }
        default:
            return UICollectionViewCell()
        }
        
    }
}

