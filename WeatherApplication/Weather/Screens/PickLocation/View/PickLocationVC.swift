//
//  PickLocationVC.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 08/10/23.
//

import UIKit
import TinyConstraints

class PickLocationVC: UIViewController {

    private let cntView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = Theme.grayishBlue
        return cv
    }()
    private let lblLocation: UILabel = {
        let label = UILabel()
        label.text = "Pick a location"
        label.font = .robotoSlabMedium(size: 30)
        label.textColor = Theme.white
        label.applyShadow()
        return label
    }()
    private let lblDesc: UILabel = {
        let label = UILabel()
        label.text = "Type the area or city you want to know the \n detailed weather information at \n this time"
        label.font = .robotoSlabLight(size: 15)
        label.textColor = Theme.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.applyShadow()
        return label
    }()
    private let txtSearchLocation: UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor =  Theme.periWinkleBlue
        txtField.layer.cornerRadius = 20
        txtField.layer.shadowColor = Theme.shadowBlack.cgColor
        txtField.layer.shadowOffset = CGSize(width: 0, height: 4)
        txtField.layer.shadowOpacity = 0.3
        txtField.placeholder = "Search"
        txtField.textColor = .white
        return txtField
    }()
    private let weatherCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 162, height: 200)
        layout.minimumLineSpacing = 39
        layout.minimumInteritemSpacing = 17
        let cv = UICollectionView( frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = Theme.grayishBlue
        cv.showsVerticalScrollIndicator = false
        cv.register(ResultCVCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    let weatherVMInst = WeatherViewModel()
    let coreDataVMInst = CoreDataViewModel()
    var weatherCDLocation: [SearchWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCDLocation = coreDataVMInst.fetchWeather()!
        observeEventWeather()
        setupUI()
        setupUIConstraints()
        setupCollectionView()
        txtSearchLocation.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(cntView)
        let componentArray = [lblLocation, lblDesc, txtSearchLocation]
        for component in componentArray {
            cntView.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupUIConstraints() {
        cntView.edgesToSuperview()
        constraintsForLocation()
        constraintsForDesc()
        constraintsForSearchTxtField()
    }
    
    private func constraintsForLocation() {
        lblLocation.centerX(to: cntView)
        lblLocation.top(to: cntView, offset: 90)
    }
    
    private func constraintsForDesc() {
        lblDesc.left(to: cntView, offset: 55)
        lblDesc.right(to: cntView, offset: -55)
        lblDesc.topToBottom(of: lblLocation, offset: 5)
    }
    
    private func constraintsForSearchTxtField() {
        txtSearchLocation.topToBottom(of: lblDesc, offset: 21)
        txtSearchLocation.height(63)
        txtSearchLocation.left(to: cntView, offset: 45)
        txtSearchLocation.right(to: cntView, offset: -45)
        setupUITextField()
    }
    
    private func setupCollectionView() {
        cntView.addSubview(weatherCV)
        weatherCV.dataSource = self
        weatherCV.delegate = self
        constrainstForWeatherCV()
    }
    
    private func constrainstForWeatherCV() {
        weatherCV.topToBottom(of: txtSearchLocation, offset: 31)
        weatherCV.left(to: cntView, offset: 45)
        weatherCV.right(to: cntView, offset: -28)
        weatherCV.bottom(to: cntView, offset: -79)
    }
    
    private func setupUITextField() {
        let placeholderText = "Search"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "RobotoSlab-Light", size: 17)! as UIFont
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)

        txtSearchLocation.attributedPlaceholder = attributedPlaceholder
        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 36, height: txtSearchLocation.frame.height))
        txtSearchLocation.leftView = leftView
        txtSearchLocation.leftViewMode = .always
        txtSearchLocation.setIcon(UIImage(named: "SearchWhite")!)
    }
    
}

extension PickLocationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let enteredText = textField.text {
            weatherVMInst.search = enteredText
            weatherVMInst.getWeatherData()
            textField.text = ""
        }
        textField.resignFirstResponder()
        return true
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
                DispatchQueue.main.async {
                    self.cdAddUpdateCall()
                    self.weatherCV.reloadData()
                }
            case .error(_):
                DispatchQueue.main.async {
                    self.showToast(message: "The City you entered might not be available", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
    
    private func cdAddUpdateCall() {
        if let weatherData = self.weatherVMInst.pickLocationData {
            let coreData = CoreDataModel(
                id: "\(weatherData.id)",
                temp: weatherData.main.temp,
                city: "\(weatherData.name), \(weatherData.sys.country)",
                image: "\(weatherData.weather[0].icon.dropLast())",
                weatherDesc: weatherData.weather[0].main
            )
            if self.coreDataVMInst.getById(id: coreData.id) {
                let _ = self.coreDataVMInst.updateWeather(data: coreData)
                self.showToast(message: "Updated weather data of city you entered", font: .systemFont(ofSize: 12.0))
            } else {
                let _ = self.coreDataVMInst.addWeather(data: coreData)
            }
        }
        self.weatherCDLocation = self.coreDataVMInst.fetchWeather()!
    }
}

extension PickLocationVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherCDLocation.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ResultCVCell
        cell!.configurationLocationCellDetails(weatherCDLocation[indexPath.row])
        return cell!
    }
}

extension PickLocationVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                cell.backgroundColor = Theme.periWinkleBlue
            } else {
                cell.backgroundColor = UIColor.white
            }
        }
}
