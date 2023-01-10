//
//  ResultsViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit

class ResultsViewController: UIViewController {

    let resultsTable = UITableView()
    
    var searchData: [DogFriendlyPlace]?
    var latitude = Double()
    var longitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .systemPurple
        view.addSubview(resultsTable)
        
        resultsTable.register(ResultsTableViewCell.self, forCellReuseIdentifier: "resultsCell")
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        APIManager.shared.getDogFriendlyResults(lat: latitude, long: longitude, completion: { (places) in
            self.searchData = places.results
            DispatchQueue.main.async {
                self.resultsTable.reloadData()
            }
        })

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultsTable.frame = view.bounds
    }


}

// MARK: Extensions: Table Delegate/Data Source

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath) as! ResultsTableViewCell
        // cell.textLabel?.text = "\(searchData?[indexPath.row].placeName ?? "") - \(searchData?[indexPath.row].distance?.description ?? "")"
        cell.placeResult = searchData?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultsTable.deselectRow(at: indexPath, animated: true)
        print(searchData![indexPath.row])
        
        // I could and perhaps should turn details into a model, then send the whole Dog Friendly Place to the constructor?
        let detailsVC = DetailsViewController()
        detailsVC.title = searchData?[indexPath.row].placeName ?? "Unknown Name"
        detailsVC.placeNameLabel.text = searchData?[indexPath.row].placeName ?? "Unknown Name"
        detailsVC.categoryLabel.text = searchData?[indexPath.row].categories?[0].name ?? ""
        detailsVC.addressLabel.text = searchData?[indexPath.row].location?.address ?? ""
        detailsVC.phoneNumberLabel.text = searchData?[indexPath.row].tel ?? ""
        detailsVC.websiteLabel.text = searchData?[indexPath.row].website ?? ""
        detailsVC.ratingsLabel.text = "\(searchData?[indexPath.row].rating?.description ?? "-")/10"
        detailsVC.fsqID = searchData?[indexPath.row].fsqId! ?? ""
        navigationController?.pushViewController(detailsVC, animated: true)
        
    }

}
