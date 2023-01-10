//
//  HomeViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    var searchQuery = ""
    
    private var currentLocation: CLPlacemark?
    
    var searchTextField = UITextField()
    let searchButton = UIButton()
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        return label
    }()
    
    let searchSuggestionsTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let formStack: UIStackView = {
        // move the config eventually
        let formStack = UIStackView()
        formStack.translatesAutoresizingMaskIntoConstraints = false
        //formStack.backgroundColor = .systemMint
        formStack.axis = .vertical
        formStack.spacing = UIStackView.spacingUseSystem
        formStack.spacing = 20.0
        formStack.isLayoutMarginsRelativeArrangement = true
        return formStack
    }()
    
    var locations = [SearchableLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        view.addSubview(welcomeLabel)
        view.addSubview(searchTextField)
        //view.addSubview(formStack)
        view.addSubview(searchSuggestionsTable)
        // arrangeStackedForm()
        addConstraints()
        configureTextField()
        configureButton()
        //attemptLocationAccess()
    }
    
    // SET UP and helper functions (connection, layout)
    
    /*private func attemptLocationAccess() {
        // try starting connection
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        
        //locationManager.delegate = self
        //locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // ask for permission
        /*if CLAuthorizationStatus.author != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestLocation()
        }*/
    }*/
    
    private func configureTextField() {
        searchTextField.delegate = self
        searchTextField.placeholder = "Address"
        searchTextField.backgroundColor = .tertiarySystemBackground
        searchTextField.layer.cornerRadius = 5
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        searchTextField.leftViewMode = .always
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
    }
    
    func configureButton() {
        // button
        searchButton.setTitle("Search", for: .normal)
        searchButton.configuration = .filled()
        searchButton.configuration?.baseBackgroundColor = .systemPink
        searchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // target
        searchButton.addTarget(self, action: #selector(didSendSearchButton), for: .touchUpInside)
    }
    
    func arrangeStackedForm() {
        // configure stackview
        configureTextField()
        configureButton()
        
        formStack.addArrangedSubview(welcomeLabel)
        formStack.addArrangedSubview(searchTextField)
        formStack.addArrangedSubview(searchButton)
    }
    
    private func addConstraints() {
        let formStackConstraints = [
            formStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            formStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            formStack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ]
        let suggestionsTableConstraints = [
            searchSuggestionsTable.topAnchor.constraint(equalTo: formStack.bottomAnchor, constant: 10),
            searchSuggestionsTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ]
        
        //formStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        // activate
        NSLayoutConstraint.activate(formStackConstraints)
       // NSLayoutConstraint.activate(suggestionsTableConstraints)
    }

    // ACTIONS
    
   /* @objc func textFieldDidChange(_ field: UITextField) {
        if currentLocation != nil {
            currentLocation = nil
            field.text = ""
        }
        
        // check query exists, then send to autocomplete
        guard let query = field.text else {
            // field was empty
            return
        }
        print("text field did change:\n\(query)")
    }*/
    
    @objc func didSendSearchButton() {
        // grab geocode from text field / current location placemark
       /* if let locationToSearch = currentLocation {
            print(locationToSearch)
        }*/
        print("hit the button: \(searchQuery)")
        //print(locationManager.location)
        
        let resultsScreen = ResultsViewController()
        resultsScreen.title = searchQuery
        navigationController?.pushViewController(resultsScreen, animated: true)
    }
    
}

// MARK: Extensions
// DELEGATES: TextField, TableView

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // set up a check for nil and whitespace (trim)!
        searchQuery += textField.text!
        print("delegate: \(searchQuery)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss keyboard
        searchTextField.resignFirstResponder()
        if let text = searchTextField.text, !text.isEmpty {
            LocationManager.shared.findLocation(with: text){ [weak self] locations in
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.searchSuggestionsTable.reloadData()
                }
            }
        }
        return true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // grab this info and use it for search
        let coordinates = locations[indexPath.row].coordinates
        print("seleted coordinates: \(coordinates)")
    }
}

/*extension HomeViewController: CLLocationManagerDelegate {
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
*/
