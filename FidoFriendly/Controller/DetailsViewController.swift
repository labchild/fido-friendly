//
//  DetailsViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit

class DetailsViewController: UIViewController {

    var placeNameLabel: UILabel = {
        var placeNameLabel = UILabel()
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        return placeNameLabel
    }()
    let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = .systemFont(ofSize: 13, weight: .regular)
        return categoryLabel
    }()
    let ratingsLabel: UILabel = {
        let ratingsLabel = UILabel()
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsLabel.font = .systemFont(ofSize: 13, weight: .regular)
        return ratingsLabel
    }()
    let addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.font = .systemFont(ofSize: 16, weight: .regular)
        addressLabel.numberOfLines = 0
        return addressLabel
    }()
    let phoneNumberLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.font = .systemFont(ofSize: 16, weight: .regular)
        return phoneNumberLabel
    }()
    let websiteLabel: UILabel = {
        let websiteLabel = UILabel()
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.font = .systemFont(ofSize: 16, weight: .regular)
        return websiteLabel
    }()
    let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save for later", for: .normal)
        saveButton.configuration = .filled()
        saveButton.configuration?.baseBackgroundColor = .systemPink
        return saveButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(placeNameLabel)
        view.addSubview(categoryLabel)
        view.addSubview(ratingsLabel)
        view.addSubview(addressLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(websiteLabel)
        view.addSubview(saveButton)
        
        configureConstraints()
    }

    func configureConstraints() {
        let placeNameLabelConstraints = [
            placeNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            placeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        let categoryLabelConstraints = [
            categoryLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7)
        ]
        let ratingsLabelConstraints = [
            ratingsLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 10),
            ratingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            ratingsLabel.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 10)
        ]
        let addressLabelConstraints = [
            addressLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        let phoneNumberLabelConstraints = [
            phoneNumberLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        let websiteLabelConstraints = [
            websiteLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10),
            websiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        let saveButtonConstraints = [
            saveButton.bottomAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 100),
            saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]

        NSLayoutConstraint.activate(placeNameLabelConstraints)
        NSLayoutConstraint.activate(categoryLabelConstraints)
        NSLayoutConstraint.activate(ratingsLabelConstraints)
        NSLayoutConstraint.activate(addressLabelConstraints)
        NSLayoutConstraint.activate(phoneNumberLabelConstraints)
        NSLayoutConstraint.activate(websiteLabelConstraints)
        NSLayoutConstraint.activate(saveButtonConstraints)
    }
}

