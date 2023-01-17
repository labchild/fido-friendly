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
        var label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    let websiteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
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
        // prepare for constraints
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let placeNameLabelConstraints = [
            placeNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            placeNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ]
        let categoryLabelConstraints = [
            categoryLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            categoryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ]
        let ratingsLabelConstraints = [
            ratingsLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 10),
            ratingsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            ratingsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ]
        let addressLabelConstraints = [
            addressLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ]
        let phoneNumberLabelConstraints = [
            phoneNumberLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ]
        let websiteLabelConstraints = [
            websiteLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10),
            websiteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(placeNameLabelConstraints)
        NSLayoutConstraint.activate(categoryLabelConstraints)
        NSLayoutConstraint.activate(ratingsLabelConstraints)
        NSLayoutConstraint.activate(addressLabelConstraints)
        NSLayoutConstraint.activate(phoneNumberLabelConstraints)
        NSLayoutConstraint.activate(websiteLabelConstraints)
    }
}
