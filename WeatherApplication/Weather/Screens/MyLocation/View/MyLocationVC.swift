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
        sv.backgroundColor = UIColor.setColor(darkColor: Theme.darkGrayishBlue, lightColor: Theme.lightGrayishBlue)
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
        label.textColor = Theme.white
        label.font = .robotoSlabMedium(size: 30)
        label.applyShadow()
        return label
    }()
    private let lblDate: UILabel = {
        let label = UILabel()
        label.textColor = Theme.white
        label.font = .robotoSlabLight(size: 15)
        label.applyShadow()
        return label
    }()
    private let imgWeather: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.applyShadow()
        return image
    }()
    private let lblTemp: UILabel = {
        let label = UILabel()
        label.textColor = Theme.white
        label.font = .robotoSlabMedium(size: 70)
        label.applyShadow()
        return label
    }()
    private let vwTemp: UIView = UIView()
    private let vwHumidity: UIView = UIView()
    private let vwWind: UIView = UIView()
    private let lblTmp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.white
        label.font = .robotoSlabLight(size: 15)
        label.text = "Temp"
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblValTmp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.white
        label.font = .robotoSlabMedium(size: 20)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblHmdty: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.white
        label.font = .robotoSlabLight(size: 15)
        label.text = "Humidity"
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblValHmdty: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.white
        label.font = .robotoSlabMedium(size: 20)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblWind: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoSlabLight(size: 15)
        label.textColor = Theme.white
        label.text = "Wind"
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblValWind: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.white
        label.font = .robotoSlabMedium(size: 20)
        label.textAlignment = .center
        label.applyShadow()
        return label
    }()
    private let lblToday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Today"
        label.textColor = Theme.white
        label.font = .robotoSlabLight(size: 20)
        label.applyShadow()
        return label
    }()
    private let btnViewReport: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("View Report", for: .normal)
        btn.setTitleColor(UIColor.setColor(darkColor: Theme.lightPeriWinkleBlue, lightColor: Theme.lightBlue), for: .normal)
        btn.titleLabel?.font = .robotoSlabLight(size: 20)
        btn.applyShadow()
        return btn
    }()
    private let iconCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 9, right: 13)
        layout.estimatedItemSize = CGSize(width: 86, height: 80)
        layout.minimumLineSpacing = 30
        let cv = UICollectionView( frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor =  UIColor.setColor(darkColor: Theme.darkSlatBlue, lightColor: Theme.lightSlatBlue)
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
        cv.backgroundColor = UIColor.setColor(darkColor: Theme.darkGrayishBlue, lightColor: Theme.lightGrayishBlue)
        cv.showsHorizontalScrollIndicator = false
        cv.clipsToBounds = false
        cv.register(forecastCVCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyBackgroundToTabBar()
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
        let componentArray = [iconCV, lblCity, lblDate, imgWeather, lblTemp, vwTemp, vwHumidity, vwWind]
        for component in componentArray {
            contentView.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
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
        constraintsForScrollView()
        constraintsForContentView()
        constraintsForIconCV()
        constraintsForCity()
        constrainstForDate()
        constraintsForImgWeather()
        constraintsForTemp()
        constraintsForTempContainer()
        constraintsForHumidityContainer()
        constraintsForWindContainer()
        constraintsForlblTemp()
        constraintsForlblHumidity()
        constraintsForlblWind()
        constraintsForlblToday()
        constraintsForBtnViewReport()
        constraintsForForecastCV()
    }
    
    private func constraintsForScrollView() {
        scrollView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height)
        scrollView.edgesToSuperview()
    }
    
    private func constraintsForContentView() {
        contentView.width(view.bounds.width)
        contentView.height(view.bounds.height)
        contentView.edges(to: scrollView)
    }
    
    private func constraintsForIconCV() {
        iconCV.height(100)
        iconCV.edges(to: contentView, excluding: .bottom)
    }
    
    private func constraintsForCity() {
        lblCity.height(40)
        lblCity.centerX(to: contentView)
        lblCity.topToBottom(of: iconCV, offset: 23)
    }
    
    private func constrainstForDate() {
        lblDate.height(20)
        lblDate.centerX(to: contentView)
        lblDate.topToBottom(of: lblCity, offset: 3)
    }
    
    private func constraintsForImgWeather() {
        imgWeather.width(155)
        imgWeather.height(155)
        imgWeather.centerX(to: contentView)
        imgWeather.topToBottom(of: lblDate, offset: 24)
    }
    
    private func constraintsForTemp() {
        lblTemp.height(92)
        lblTemp.centerX(to: contentView)
        lblTemp.topToBottom(of: imgWeather)
    }
    
    private func constraintsForTempContainer() {
        vwTemp.width(80)
        vwTemp.height(50)
        vwTemp.topToBottom(of: lblTemp, offset: 38)
        vwTemp.left(to: contentView, offset: 38)
    }
    
    private func constraintsForHumidityContainer() {
        vwHumidity.width(80)
        vwHumidity.height(50)
        vwHumidity.leftToRight(of: vwTemp, offset: 60)
        vwHumidity.centerY(to: vwTemp)
    }
    
    private func constraintsForWindContainer() {
        vwWind.width(80)
        vwWind.height(50)
        vwWind.leftToRight(of: vwHumidity, offset: 60)
        vwWind.centerY(to: vwHumidity)
    }
    
    private func constraintsForlblTemp() {
        lblTmp.height(20)
        lblTmp.edges(to: vwTemp, excluding: .bottom, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        lblValTmp.centerX(to: lblTmp)
        lblValTmp.topToBottom(of: lblTmp)
    }
    
    private func constraintsForlblHumidity() {
        lblHmdty.height(20)
        lblHmdty.edges(to: vwHumidity, excluding: .bottom, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        lblValHmdty.topToBottom(of: lblTmp)
        lblValHmdty.centerX(to: lblHmdty)
    }
    
    private func constraintsForlblWind() {
        lblWind.height(20)
        lblWind.edges(to: vwWind, excluding: .bottom, insets: TinyEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        lblValWind.centerX(to: lblWind)
        lblValWind.topToBottom(of: lblTmp)
    }
    
    private func constraintsForlblToday() {
        lblToday.left(to: contentView, offset: 24)
        lblToday.topToBottom(of: vwTemp, offset: 31)
    }
    
    private func constraintsForBtnViewReport() {
        btnViewReport.topToBottom(of: vwWind, offset: 31)
        btnViewReport.right(to: contentView, offset: -21)
    }
    
    private func constraintsForForecastCV() {
        forecastCV.topToBottom(of: btnViewReport, offset: 31)
        forecastCV.left(to: contentView, offset: 10)
        forecastCV.right(to: contentView, offset: 10)
        forecastCV.height(90)
    }
    
    private func setUpdelegateDataSourceCV() {
        iconCV.dataSource = self
        forecastCV.dataSource = self
        forecastCV.delegate = self
    }
    
    @objc func viewReportTapped() {
        let forecastReportVC = self.storyboard?.instantiateViewController(withIdentifier: "ForecastReportVC") as! ForecastReportVC
        forecastReportVC.forecastData = forecastVMInst.forecastData
        self.navigationController?.pushViewController(forecastReportVC, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else { return }
        
        weatherVMInst.lat = first.coordinate.latitude
        weatherVMInst.lon = first.coordinate.longitude
        forecastVMInst.lat = first.coordinate.latitude
        forecastVMInst.lon = first.coordinate.longitude
        weatherVMInst.getWeatherData()
        forecastVMInst.getWeatherData()
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

extension MyLocationVC: UICollectionViewDataSource {

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

extension MyLocationVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.setColor(darkColor: Theme.lightPeriWinkleBlue, lightColor: Theme.white)
                if let cell = cell as? forecastCVCell {
                    cell.lblTime.textColor = Theme.black
                    cell.lblTemp.textColor = Theme.black
                }
            } else {
                cell.backgroundColor = UIColor.setColor(darkColor: Theme.darkPeriWinkleBlue, lightColor: Theme.lightPeriWinkleBlue)
                if let cell = cell as? forecastCVCell {
                    cell.lblTime.textColor = Theme.white
                    cell.lblTemp.textColor = Theme.white
                }
            }
        }
}

