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
    var savedPlaces = [TestEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(savedPlaceTable)
        
        savedPlaceTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        savedPlaceTable.delegate = self
        savedPlaceTable.dataSource = self
        getSavedPlaces()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        savedPlaceTable.frame = view.bounds
    }
    
    private func getSavedPlaces() {
        fetchPlaces()
        savedPlaceTable.reloadData()
    }

}

extension SavedPlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if savedPlaces.count < 1 {
            return 1
        }
        return savedPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if savedPlaces.count < 1 {
            cell.textLabel?.text = "You haven't saved any dog-friendly places yet."
        }
        cell.textLabel?.text = savedPlaces[indexPath.row].testName
        return cell
    }
}

extension SavedPlacesViewController {
    func fetchPlaces() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<TestEntity>(entityName: "TestEntity")
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results {
                    if let testName = result.testName {
                        print(testName)
                    }
                }
                
                savedPlaces = results
            } catch {
                print("couldn't retrieve")
                print(error)
            }
        }
    }
}
