//
//  HomeViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit

class HomeViewController: UIViewController {

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        return label
    }()
    let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter an address"
        field.layer.cornerRadius = 8
        field.backgroundColor = .tertiarySystemBackground
        return field
    }()
    let searchButton = UIButton()
   /* private var categoryPickers = [UISwitch]()
    let formStack: UIStackView = {
        // move the config to a view eventually
        let formStack = UIStackView()
        formStack.translatesAutoresizingMaskIntoConstraints = false
        formStack.backgroundColor = .systemMint
        formStack.axis = .vertical
        //formStack.distribution = .equalCentering
        formStack.spacing = UIStackView.spacingUseSystem
        formStack.spacing = 20.0
        formStack.isLayoutMarginsRelativeArrangement = true
        return formStack
    }()*/
    
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
        // button
        searchButton.setTitle("Search", for: .normal)
        searchButton.configuration = .filled()
        searchButton.configuration?.baseBackgroundColor = .systemPink
        searchButton.addTarget(self, action: #selector(didSendSearchButton), for: .touchUpInside)
        
        // add constraints if I need them
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
    
   /* func createCategorySwitches() {
        let categories = ["Dining & Drinking", "Parks & Outdoor Spaces","Veterinary", "Shopping", "Services"]
        
        for category in categories {
            let checkbox = UISwitch()
            checkbox.title = category
            categoryPickers.append(checkbox)
        }
    }*/
   
    /*func arrangeStackedForm() {
    // configure stackview
        configButton()
        //createCategorySwitches()
        
        // text field
        textField.placeholder = "Address"
        textField.backgroundColor = .systemBackground
        /*for checkbox in categoryPickers {
            formStack.addArrangedSubview(checkbox)
        }*/
        
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
    } */

    @objc func didSendSearchButton() {
        // logic will need to capture text field text and query API
        let resultsScreen = ResultsViewController()
        resultsScreen.title = "Results"
        navigationController?.pushViewController(resultsScreen, animated: true)
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            LocationManager.shared.findLocation(with: text) { [weak self] locations in
                self?.locations = locations
                print(locations)
            }
        }
          return true
    }
}
