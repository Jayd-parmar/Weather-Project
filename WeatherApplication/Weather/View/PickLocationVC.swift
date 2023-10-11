//
//  PickLocationVC.swift
//  WeatherApplication
//
//  Created by Jaydip Parmar on 08/10/23.
//

import UIKit
import TinyConstraints

class PickLocationVC: UIViewController {

    var cntView = UIView()
    var lblLocation = UILabel()
    var lblDesc = UILabel()
    var txtSearchLocation = UITextField()
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
    
    func setupUI() {
        view.addSubview(cntView)
        cntView.translatesAutoresizingMaskIntoConstraints = false
        cntView.edgesToSuperview()
        cntView.backgroundColor = UIColor(red: 0.51, green: 0.549, blue: 0.682, alpha: 1)
        cntView.addSubview(lblLocation)
        lblLocation.translatesAutoresizingMaskIntoConstraints = false
        lblLocation.centerX(to: cntView)
        lblLocation.top(to: cntView, offset: 90)
        lblLocation.text = "Pick a location"
        lblLocation.font = UIFont.boldSystemFont(ofSize: 30.0)
        lblLocation.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        cntView.addSubview(lblDesc)
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        lblDesc.text = "Type the area or city you want to know the \n detailed weather information at \n this time"
        lblDesc.left(to: cntView, offset: 55)
        lblDesc.right(to: cntView, offset: -55)
        lblDesc.font = UIFont.systemFont(ofSize: 15.0)
        lblDesc.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lblDesc.textAlignment = .center
        lblDesc.topToBottom(of: lblLocation, offset: 5)
        lblDesc.numberOfLines = 0
        
        cntView.addSubview(txtSearchLocation)
        txtSearchLocation.translatesAutoresizingMaskIntoConstraints = false
        txtSearchLocation.topToBottom(of: lblDesc, offset: 21)
        txtSearchLocation.height(63)
        txtSearchLocation.left(to: cntView, offset: 45)
        txtSearchLocation.right(to: cntView, offset: -45)
        txtSearchLocation.backgroundColor =  UIColor(red: 0.656, green: 0.706, blue: 0.879, alpha: 1)
        txtSearchLocation.layer.cornerRadius = 20
        txtSearchLocation.placeholder = "Search"
        
        let placeholderText = "Search"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)

        txtSearchLocation.attributedPlaceholder = attributedPlaceholder
        txtSearchLocation.textColor = .white
        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 36, height: txtSearchLocation.frame.height))
        txtSearchLocation.leftView = leftView
        txtSearchLocation.leftViewMode = .always
        txtSearchLocation.setIcon(UIImage(named: "SearchWhite")!)
    }
    
    func setupCollectionView() {
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
                print("data loaded")
                weatherLocationData.append(weatherVMInst.pickLocationData!)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .error(_):
                print("error")
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
