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
        label.font = UIFont.systemFont(ofSize: 30.0)
        return label
    }()
    private let lblDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    private let imgWeather: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    private let lblTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 70.0)
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
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "Temp"
        label.textAlignment = .center
        return label
    }()
    private let lblValTmp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        return label
    }()
    private let lblHmdty: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "Humidity"
        label.textAlignment = .center
        return label
    }()
    private let lblValHmdty: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        return label
    }()
    private let lblWind: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = "Wind"
        label.textAlignment = .center
        return label
    }()
    private let lblValWind: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textAlignment = .center
        return label
    }()
    private let lblToday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Today"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    private let btnViewReport: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("View Report", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    var forecastCV: UICollectionView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupUIConstraints()
        setUpUICollectionView()
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
    }
    
    private func setupUIConstraints() {
        scrollView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height)
        scrollView.edgesToSuperview()
        
        contentView.width(view.bounds.width)
        contentView.height(view.bounds.height)
        contentView.edges(to: scrollView)
        
        lblCity.height(40)
        lblCity.centerX(to: contentView)
        lblCity.top(to: contentView, offset: 100)
        
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
    }
    
    private func setUpUICollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 166, height: 85)
        layout.minimumLineSpacing = 20

        forecastCV = UICollectionView( frame: .zero, collectionViewLayout: layout)
        forecastCV.translatesAutoresizingMaskIntoConstraints = false
        forecastCV.delegate = self
        forecastCV.dataSource = self
        forecastCV.backgroundColor = UIColor(red: 0.51, green: 0.549, blue: 0.682, alpha: 1)
        forecastCV.showsHorizontalScrollIndicator = false
        forecastCV.register(forecastCVCell.self, forCellWithReuseIdentifier: "cell")
        contentView.addSubview(forecastCV)
        
        forecastCV.topToBottom(of: btnViewReport, offset: 31)
        forecastCV.left(to: contentView, offset: 10)
        forecastCV.right(to: contentView, offset: 10)
        forecastCV.height(85)
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
        weatherVMInst.getWeatherData(search: nil)
        forecastVMInst.getForecastData()
    }
    
    private func observeEventWeather() {
        weatherVMInst.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                print("loading....")
            case .stopLoading:
                print("stop loading...")
            case .dataLoaded:
                print("data loaded")
                    DispatchQueue.main.async {
                        self.configureWeatherDetails()
                    }
            case .error(_):
                print("error")
            }
        }
    }
    
    private func configureWeatherDetails() {
        guard let weather = weatherVMInst.weatherData else { return }
        lblCity.text = weather.name
        formatDate(dt: weather.dt)
        lblTemp.text = "\(weather.main.temp) c"
        lblValTmp.text = "\(weather.main.temp) c"
        lblValHmdty.text = "\(weather.main.humidity)%"
        lblValWind.text = "\(weather.wind.speed) kmph"
        imgWeather.setImage(with: "\(Constant.URL.weatherImageUrl)\(weather.weather[0].icon)@2x.png")
    }
    
    private func formatDate(dt: Int) {
        let timestamp = TimeInterval(dt)
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let formattedDate = dateFormatter.string(from: date)
        lblDate.text = formattedDate
    }
    
    private func observeEventForecast() {
        forecastVMInst.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                print("loading....")
            case .stopLoading:
                print("stop loading...")
            case .dataLoaded:
                print("data loaded")
                DispatchQueue.main.async {
                    self.forecastCV.reloadData()
                }
            case .error(_):
                print("error")
            }
        }
    }
}

extension MyLocationVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (forecastVMInst.forecastData?.list.count) ?? 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let forecastData = forecastVMInst.forecastData?.list {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? forecastCVCell
            cell!.configureForecastCellDetails(forecastData[indexPath.row])
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? forecastCVCell
            cell!.configureDefaultDetails()
            return cell!
        }
    }
}
