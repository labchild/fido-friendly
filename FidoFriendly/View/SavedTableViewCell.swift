//
//  SavedTableViewCell.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/10/23.
//

import UIKit

class SavedTableViewCell: UITableViewCell {

    var savedPlace: TestEntity? {
        didSet {
            placeNameLabel.text = savedPlace?.placeName
            fsqID = savedPlace?.fsqID ?? ""
        }
    }
    
    var fsqID = String()
    
    // ui elements to include in cell
    let placeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let subtitleStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 5
        // stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.insetsLayoutMarginsFromSafeArea = true
        //self.layoutMargins = UIEdgeInsets(top: 50, left: 10, bottom: -10, right: -10)
        addSubview(placeNameLabel)
        
        //addSubview(subtitleStack)
        configureConstraints()
    }

    private func configureConstraints() {
        // prepare components for constraints
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // constraint arrays
        let placeNameLabelConstraints = [
            placeNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            placeNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ]
        
        // activate constraints
        NSLayoutConstraint.activate(placeNameLabelConstraints)
        
    }
    
    // required method
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

