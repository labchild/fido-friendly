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
        label.text = "Ready to bring Fido?"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let welcomeSubtitle: UILabel = {
        let label = UILabel()
        label.text = "Search for dog-friendly places nearby."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter an address"
        field.layer.cornerRadius = 8
        field.backgroundColor = .tertiarySystemBackground
        return field
    }()
    
    private let backgroundImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let backgroundIcon = UIImage(systemName: "pawprint.circle.fill")
    let iconConfig = UIImage.SymbolConfiguration(paletteColors: [.systemGreen, .green])
    
    var locations = [SearchableLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen

        view.addSubview(welcomeLabel)
        view.addSubview(welcomeSubtitle)
        view.addSubview(textField)
        //view.addSubview(backgroundImage)
        addConstraints()
        assignBackground()
        
        textField.delegate = self
    }

    
    func addConstraints() {
    
        //label
        welcomeLabel.sizeToFit()
        welcomeLabel.frame = CGRect(x: 10, y: 10, width: welcomeLabel.frame.size.width, height: welcomeLabel.frame.size.height)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        welcomeSubtitle.sizeToFit()
        welcomeSubtitle.frame = CGRect(x: 10, y: welcomeLabel.frame.size.height-15, width: welcomeSubtitle.frame.size.width, height: welcomeSubtitle.frame.size.height)
        welcomeSubtitle.translatesAutoresizingMaskIntoConstraints = false
        welcomeSubtitle.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5).isActive = true
        welcomeSubtitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        // text field
        textField.frame = CGRect(x: 20, y: 160, width: view.frame.size.width-40, height: 40)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        
        /*backgroundImage.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        let backgroundConstraints = [
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.widthAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1)
        ]
        NSLayoutConstraint.activate(backgroundConstraints)*/
        backgroundImage.center = view.center
    }
    
    private func assignBackground() {
        // let background = UIImage(named: "dog-glasses")
        backgroundImage.image = backgroundIcon

        view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)
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
