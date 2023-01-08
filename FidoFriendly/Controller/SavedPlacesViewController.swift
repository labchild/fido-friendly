//
//  FavoritesViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit

class SavedPlacesViewController: UIViewController {

    let savedPlaceTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(savedPlaceTable)
        
        savedPlaceTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        savedPlaceTable.delegate = self
        savedPlaceTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        savedPlaceTable.frame = view.bounds
    }

}

extension SavedPlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Saved Place \(indexPath.row)"
        return cell
    }
}
