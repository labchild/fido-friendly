//
//  FavoritesViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit
import CoreData

class SavedPlacesViewController: UIViewController {

    private let savedPlaceTable = UITableView()
    private let titleLabel = UILabel()
    var savedPlaces = [TestEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        view.addSubview(titleLabel)
        view.addSubview(savedPlaceTable)
        savedPlaceTable.backgroundColor = .systemGreen
        titleLabel.text = "Your Saved Places"
        //titleLabel.frame = CGRect(x: 0, y: 0, width: self., height: <#T##Double#>)
        
        savedPlaceTable.register(SavedTableViewCell.self, forCellReuseIdentifier: "cell")
        savedPlaceTable.delegate = self
        savedPlaceTable.dataSource = self
        getSavedPlaces()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        savedPlaceTable.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getSavedPlaces()
    }
    
    private func getSavedPlaces() {
        fetchPlaces()
        savedPlaceTable.reloadData()
    }

}

// MARK: Extensions: TableView Delegate, Datasource; Core Data Fetch

extension SavedPlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if savedPlaces.count < 1 {
            return 1
        }
        return savedPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SavedTableViewCell
        if savedPlaces.count < 1 {
            cell.placeNameLabel.text = "You haven't saved any dog-friendly places yet."
        }
        cell.savedPlace = savedPlaces[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if savedPlaces.count < 1 {
            return
        }
        
        savedPlaceTable.deselectRow(at: indexPath, animated: true)
        
        if let id = savedPlaces[indexPath.row].fsqID {
            let detailsVC = DetailsViewController()
            detailsVC.fsqID = id
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension SavedPlacesViewController {
    func fetchPlaces() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<TestEntity>(entityName: "TestEntity")
            
            do {
                let results = try context.fetch(fetchRequest)
                // make it available to the view controller
                savedPlaces = results
                
            } catch {
                print("couldn't retrieve")
                print(error)
            }
        }
    }
}
