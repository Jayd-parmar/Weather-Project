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
        cv.backgroundColor = UIColor(red: 0.51, green: 0.549, blue: 0.682, alpha: 1)
        return cv
    }()
    private let lblLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pick a location"
        label.font = .robotoSlabMedium(size: 30)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.applyShadow()
        return label
    }()
    private let lblDesc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Type the area or city you want to know the \n detailed weather information at \n this time"
        label.font = .robotoSlabLight(size: 15)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.applyShadow()
        return label
    }()
    private let txtSearchLocation: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.backgroundColor =  UIColor(red: 0.656, green: 0.706, blue: 0.879, alpha: 1)
        txtField.layer.cornerRadius = 20
        txtField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        txtField.layer.shadowOffset = CGSize(width: 0, height: 4)
        txtField.layer.shadowOpacity = 0.3
        txtField.placeholder = "Search"
        txtField.textColor = .white
        return txtField
    }()
    let weatherVMInst = WeatherViewModel()
    var weatherLocationData: [WeatherResponse] = []
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeEventWeather()
        setupUI()
        setupCollectionView()
        txtSearchLocation.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(cntView)
        cntView.addSubview(lblLocation)
        cntView.addSubview(lblDesc)
        cntView.addSubview(txtSearchLocation)
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        cntView.edgesToSuperview()
        lblLocation.centerX(to: cntView)
        lblLocation.top(to: cntView, offset: 90)
        lblDesc.left(to: cntView, offset: 55)
        lblDesc.right(to: cntView, offset: -55)
        lblDesc.topToBottom(of: lblLocation, offset: 5)
        txtSearchLocation.topToBottom(of: lblDesc, offset: 21)
        txtSearchLocation.height(63)
        txtSearchLocation.left(to: cntView, offset: 45)
        txtSearchLocation.right(to: cntView, offset: -45)
        setupUITextField()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 162, height: 200)
        layout.minimumLineSpacing = 39
        layout.minimumInteritemSpacing = 17
        collectionView = UICollectionView( frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 0.51, green: 0.549, blue: 0.682, alpha: 1)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ResultCVCell.self, forCellWithReuseIdentifier: "cell")
        cntView.addSubview(collectionView)
        
        collectionView.topToBottom(of: txtSearchLocation, offset: 31)
        collectionView.left(to: cntView, offset: 45)
        collectionView.right(to: cntView, offset: -28)
        collectionView.bottom(to: cntView, offset: -79)
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
            APIManager.searchCity = enteredText
            weatherVMInst.getWeatherData(search: enteredText)
            textField.text = ""
        }
        textField.resignFirstResponder()
        return true
    }
    
    func observeEventWeather() {
        weatherVMInst.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                print("loading....")
            case .stopLoading:
                print("stop loading...")
            case .dataLoaded:
                weatherLocationData.insert(weatherVMInst.pickLocationData!, at: 0)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .error(_):
                DispatchQueue.main.async {
                    self.showToast(message: "The City you entered might not be available", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
}

extension PickLocationVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherLocationData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ResultCVCell
        cell!.configurationLocationCellDetails(weatherLocationData[indexPath.row])
        return cell!
    }
}
