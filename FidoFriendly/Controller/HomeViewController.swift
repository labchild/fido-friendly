//
//  HomeViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLPlacemark?

    let textField = UITextField()
    
    let searchSuggestionsTable = UITableView()
    let searchButton = UIButton()
    let formStack: UIStackView = {
        // move the config eventually
        let formStack = UIStackView()
        formStack.translatesAutoresizingMaskIntoConstraints = false
        formStack.backgroundColor = .systemMint
        formStack.axis = .vertical
        formStack.spacing = UIStackView.spacingUseSystem
        formStack.spacing = 20.0
        formStack.isLayoutMarginsRelativeArrangement = true
        return formStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        view.addSubview(formStack)
        arrangeStackedForm()
        addStackConstraints()
        
        attemptLocationAccess()
    }
    
    // SET UP and helper functions (connection, layout)
    
    private func attemptLocationAccess() {
        // try starting connection
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // ask for permission
        /*if CLLocationManager. {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestLocation()
        }*/
    }
    
    private func configureTextField() {
        // textField.delegate = self
        textField.placeholder = "Address"
        textField.backgroundColor = .systemBackground
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
    }
    
    func configButton() {
        // button
        searchButton.setTitle("Search", for: .normal)
        searchButton.configuration = .filled()
        searchButton.configuration?.baseBackgroundColor = .systemPink
        
        // target
        searchButton.addTarget(self, action: #selector(didSendSearchButton), for: .touchUpInside)
    }
    
    func arrangeStackedForm() {
        // configure stackview
        configureTextField()
        configButton()
        
        formStack.addArrangedSubview(textField)
        formStack.addArrangedSubview(searchButton)
    }
    
    func addStackConstraints() {
        let formStackConstraints = [
            formStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            formStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            formStack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7)
        ]
        
        formStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        // activate
        NSLayoutConstraint.activate(formStackConstraints)
    }

    // ACTIONS
    
    @objc func textFieldDidChange(_ field: UITextField) {
        if currentLocation != nil {
            currentLocation = nil
            field.text = ""
        }
        
        // check query exists, then send to autocomplete
        guard let query = field.text else {
            // field was empty
            return
        }
        print(query)
    }
    
    @objc func didSendSearchButton() {
        // grab geocode from text field / current location placemark
        if let locationToSearch = currentLocation {
            print(locationToSearch)
        }
        
        print(locationManager.location)
        
        let resultsScreen = ResultsViewController()
        resultsScreen.title = "Results"
        navigationController?.pushViewController(resultsScreen, animated: true)
    }
    
}

// MARK: Extensions
// DELEGATES: TextField, LocationManager

extension HomeViewController: CLLocationManagerDelegate {
    // this happens when user responds to permission/changes settings
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        manager.requestLocation()
    }
    
    // update locations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print("location: \(location)")
        
        // search completer goes here
        
        
        // save geocode and address
        /*
        CLGeocoder().reverseGeocodeLocation(location) { (places, _) in
            guard let firstAddress = places?.first,
               self.textField.text == nil
            else {
                return
            }
            
            // store the location and update text field!
            self.currentLocation = firstAddress
            self.textField.text = firstAddress.name
            print("printing:\n", firstAddress)
            print(firstAddress.name)
            print("location: \(firstAddress.location)")
        }*/
    }
    
    
    
    // error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)\nerror:\(error)")
    }
}
