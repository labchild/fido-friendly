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

        view.backgroundColor = .systemGreen
        view.addSubview(savedPlaceTable)
        savedPlaceTable.backgroundColor = .systemGreen
        
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
    
    // table header
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: header.frame.size.width, height: header.frame.size.height-10))
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .label
        label.text = "Your Saved Places"
        header.addSubview(label)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // table cells
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
            cell.placeNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        } else {
            cell.savedPlace = savedPlaces[indexPath.row]
        }
        return cell
    }
    
    // table actions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        savedPlaceTable.deselectRow(at: indexPath, animated: true)
        
        if savedPlaces.count < 1 {
            return
        }
        
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
                if results.count < 1 {
                    return
                } else {
                    savedPlaces = results
                }
                
            } catch {
                print("couldn't retrieve:\n\(error)")
            }
        }
    }
}
