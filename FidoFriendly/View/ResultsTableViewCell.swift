//
//  ResultsTableViewCell.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/9/23.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    // get and set place from data model
    var placeResult: DogFriendlyPlace? {
        didSet {
            let distanceInMiles = UnitConverter.shared.metersToMiles(meters: placeResult?.distance)
            
            placeNameLabel.text = placeResult?.placeName
            categoryLabel.text = placeResult?.categories?.first?.name
            distanceLabel.text = "\(distanceInMiles.description) mi"
        }
    }
    
    // ui elements to include in cell
    let placeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
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
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.insetsLayoutMarginsFromSafeArea = true
        //self.layoutMargins = UIEdgeInsets(top: 50, left: 10, bottom: -10, right: -10)
        addSubview(placeNameLabel)
        
        subtitleStack.addArrangedSubview(categoryLabel)
        subtitleStack.addArrangedSubview(distanceLabel)
        addSubview(subtitleStack)
        configureConstraints()
    }
    
    /*override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        self.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)
    }*/
    
    private func configureConstraints() {
        // prepare components for constraints
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleStack.translatesAutoresizingMaskIntoConstraints = false
        
        // constraint arrays
        let placeNameLabelConstraints = [
            placeNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            placeNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ]
        let categoryLabelConstraints = [
            categoryLabel.topAnchor.constraint(equalTo: subtitleStack.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: subtitleStack.leadingAnchor),
            categoryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ]
        let distanceLabelConstraints = [
            distanceLabel.topAnchor.constraint(equalTo: subtitleStack.topAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: subtitleStack.trailingAnchor),
            distanceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ]
        let subtitleStackContraints = [
            subtitleStack.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 6),
            subtitleStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            subtitleStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        
        // activate constraints
        NSLayoutConstraint.activate(placeNameLabelConstraints)
        NSLayoutConstraint.activate(subtitleStackContraints)
        NSLayoutConstraint.activate(categoryLabelConstraints)
        NSLayoutConstraint.activate(distanceLabelConstraints)
        
    }
    
    // required method
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
