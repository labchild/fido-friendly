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
    
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter an address"
        field.layer.cornerRadius = 8
        field.backgroundColor = .tertiarySystemBackground
        return field
    }()
    
   /* private let suggestionsTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .systemPink
        return table
    }()
    let searchButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Search", for: .normal)
        btn.configuration = .filled()
        btn.configuration?.baseBackgroundColor = .systemPink
        return btn
    }()*/
    
    private let suggestionLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    
    var locations = [SearchableLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue

        view.addSubview(welcomeLabel)
        view.addSubview(textField)
        //view.addSubview(searchButton)
        //view.addSubview(suggestionsTable)
        //view.addSubview(suggestionLabel)
        addConstraints()
        
        textField.delegate = self
        //suggestionsTable.delegate = self
        //suggestionsTable.dataSource = self
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
        
        /* button
        //searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.frame = CGRect(x: 10,
                                    y: 190,
                                    width: view.frame.size.width-30,
                                    height: 40)
        searchButton.addTarget(self, action: #selector(didSendSearchButton), for: .touchUpInside)
         */
        
        // tableview
        /*suggestionsTable.frame = CGRect(
            x: 10,
            y: welcomeLabel.frame.size.height+textField.frame.size.height+50,
            width: view.frame.size.width,
            height: view.frame.size.height-welcomeLabel.frame.size.height-textField.frame.size.height
        )
        suggestionsTable.translatesAutoresizingMaskIntoConstraints = false
        suggestionsTable.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true*/
        
        // suggestion label
        //suggestionLabel.translatesAutoresizingMaskIntoConstraints
        
    }
    
    private func showSuggestion(_ suggestion: String) {
        suggestionLabel.text = suggestion
        self.view.layoutIfNeeded()
      //suggestionContainerTopConstraint.constant = -4 // to hide the top corners

      /*UIView.animate(withDuration: defaultAnimationDuration) {
        self.view.layoutIfNeeded()
      }*/
    }
    
    func sendSearch(with query: SearchableLocation) {
        print("<------in send func----------->")
        print(query)
        
        
        let resultsScreen = ResultsViewController()
        resultsScreen.title = query.title
        resultsScreen.latitude = query.coordinates?.latitude ?? 45
        resultsScreen.longitude = query.coordinates?.longitude ?? -93
        navigationController?.pushViewController(resultsScreen, animated: true)
    }
    
    // MARK: Actions

    /*@objc func didSendSearchButton() {
        // logic will need to capture text field text and query API
        guard let query = locations.first else {return}
        sendSearch(with: query)
    }*/
    
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
                    print("text delegate:")
                    print(locations)
                    self?.sendSearch(with: query)
                    
                
            }
        }
          return true
    }
}

/*extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "hello"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell clicked!")
        print(locations[indexPath.row].title)
    }
}
*/
