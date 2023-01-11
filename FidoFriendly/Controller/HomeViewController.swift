//
//  HomeViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
// TODO: implement auto complete text field and suggestions table

import UIKit

class HomeViewController: UIViewController {

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter an address"
        field.layer.cornerRadius = 8
        field.backgroundColor = .tertiarySystemBackground
        return field
    }()
    
    var locations = [SearchableLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue

        view.addSubview(welcomeLabel)
        view.addSubview(textField)
        addConstraints()
        
        textField.delegate = self
    }

    
    func addConstraints() {
    
        //label
        welcomeLabel.sizeToFit()
        welcomeLabel.frame = CGRect(x: 10, y: 10, width: welcomeLabel.frame.size.width, height: welcomeLabel.frame.size.height)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        // text field
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        textField.frame = CGRect(x: 10, y: 130, width: view.frame.size.width-30, height: 40)
        
    }
    
    func sendSearch(with query: SearchableLocation) {
        
        let resultsScreen = ResultsViewController()
        resultsScreen.title = query.title
        resultsScreen.latitude = query.coordinates?.latitude ?? 45
        resultsScreen.longitude = query.coordinates?.longitude ?? -93
        navigationController?.pushViewController(resultsScreen, animated: true)
    }
    
}


// MARK: Extensions (delegate and datasource)

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard
        textField.resignFirstResponder()
        
        if let text = textField.text, !text.isEmpty {
                LocationManager.shared.findLocation(with: text) { [weak self] locations in
                    self?.locations = locations
                    guard let query = locations.first else { return }
                    self?.sendSearch(with: query)

            }
        }
          return true
    }
}
