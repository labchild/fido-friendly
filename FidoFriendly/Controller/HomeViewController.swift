//
//  HomeViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit

class HomeViewController: UIViewController {

    private let textField = UITextField()
    private let searchButton = UIButton()
    private let formStack: UIStackView = {
        let formStack = UIStackView()
        formStack.translatesAutoresizingMaskIntoConstraints = false
        formStack.backgroundColor = .systemMint
        formStack.axis = .vertical
        return formStack
    }()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(formStack)
        arrangeStackedForm()
        addStackConstraints()
    }
   
    private func arrangeStackedForm() {
        // configure stackview
        
        
        // text field
        textField.text = "Address"
        textField.backgroundColor = .systemBackground
        
        // button
        searchButton.setTitle("Search", for: .normal)
        searchButton.configuration = .filled()
        searchButton.configuration?.baseBackgroundColor = .systemPink
        
        formStack.addArrangedSubview(textField)
        formStack.addArrangedSubview(searchButton)
    }
    
    private func addStackConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // center stack
        constraints.append(formStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(formStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor))
        
        // static shape for stack
        constraints.append(formStack.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50))
        constraints.append(formStack.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50))
        constraints.append(formStack.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50))
        constraints.append(formStack.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50))
        
        // activate
        NSLayoutConstraint.activate(constraints)
    }

}
