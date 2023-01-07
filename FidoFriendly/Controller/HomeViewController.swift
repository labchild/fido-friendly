//
//  HomeViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit

class HomeViewController: UIViewController {

    let textField = UITextField()
    let searchButton = UIButton()
   /* private var categoryPickers = [UISwitch]()*/
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
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(formStack)
        arrangeStackedForm()
        addStackConstraints()
    }
    
    func configButton() {
        // button
        searchButton.setTitle("Search", for: .normal)
        searchButton.configuration = .filled()
        searchButton.configuration?.baseBackgroundColor = .systemPink
        
        // target
        searchButton.addTarget(self, action: #selector(didSendSearchButton), for: .touchUpInside)
        
        // add constraints if I need them
    }
    
   /* func createCategorySwitches() {
        let categories = ["Dining & Drinking", "Parks & Outdoor Spaces","Veterinary", "Shopping", "Services"]
        
        for category in categories {
            let checkbox = UISwitch()
            checkbox.title = category
            categoryPickers.append(checkbox)
        }
    }*/
   
    func arrangeStackedForm() {
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
    }

    @objc func didSendSearchButton() {
        // logic will need to capture text field text and query API
        let resultsScreen = ResultsViewController()
        resultsScreen.title = "Results"
        navigationController?.pushViewController(resultsScreen, animated: true)
    }
    
}
