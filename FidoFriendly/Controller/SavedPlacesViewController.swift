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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        savedPlaceTable.deselectRow(at: indexPath, animated: true)
        if let id = savedPlaces[indexPath.row].fsqID {
            let detailsVC = DetailsViewController()
            
            /*APIManager.shared.getOneDogFriendlyResult(fsqID: id) { place in
                // detailsView(place) and pass off with nav controller
                DispatchQueue.main.async {
                    placeDetails = place
                }
                print("inside!!         !!")
                print(placeDetails)
            }
            // sending to details view
            detailsVC.title = placeDetails.placeName ?? "Unknown Name"
            detailsVC.placeNameLabel.text = placeDetails.placeName ?? "Unknown Name"
            detailsVC.categoryLabel.text = placeDetails.categories?.first?.name ?? ""
            detailsVC.addressLabel.text = placeDetails.location?.address ?? ""
            detailsVC.phoneNumberLabel.text = placeDetails.tel ?? ""
            detailsVC.websiteLabel.text = placeDetails.website ?? ""
            detailsVC.ratingsLabel.text = "\(placeDetails.rating?.description ?? "-")/10"*/
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
                
                for result in results {
                    if let placeName = result.placeName {
                        print(placeName)
                    }
                }
                
                // make our data available to the rest of the view
                savedPlaces = results
                print(results)
                
            } catch {
                print("couldn't retrieve")
                print(error)
            }
        }
    }
}
