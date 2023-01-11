//
//  DetailsView.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/10/23.
//

import UIKit

class DetailsView: UIView {

    var fsqID = String()
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(placeNameLabel)
        addSubview(categoryLabel)
        addSubview(ratingsLabel)
        addSubview(addressLabel)
        addSubview(phoneNumberLabel)
        addSubview(websiteLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        placeNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        let placeNameLabelConstraints = [
            placeNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            placeNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ]
        let categoryLabelConstraints = [
            categoryLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ]
        let ratingsLabelConstraints = [
            ratingsLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 10),
            ratingsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            ratingsLabel.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 10)
        ]
        let addressLabelConstraints = [
            addressLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ]
        let phoneNumberLabelConstraints = [
            phoneNumberLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ]
        let websiteLabelConstraints = [
            websiteLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10),
            websiteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(placeNameLabelConstraints)
        NSLayoutConstraint.activate(categoryLabelConstraints)
        NSLayoutConstraint.activate(ratingsLabelConstraints)
        NSLayoutConstraint.activate(addressLabelConstraints)
        NSLayoutConstraint.activate(phoneNumberLabelConstraints)
        NSLayoutConstraint.activate(websiteLabelConstraints)
    }
}
