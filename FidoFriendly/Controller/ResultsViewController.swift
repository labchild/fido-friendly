//
//  ResultsViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit

class ResultsViewController: UIViewController {

    let resultsTable = UITableView()
    
    var searchData = [DogFriendlyPlace]()
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
        
        if searchData.count < 1 {
            return 1
        }
        return searchData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath) as! ResultsTableViewCell
        
        if searchData.count < 1 {
            cell.placeNameLabel.text = "No results"
        } else {
            cell.placeResult = searchData[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchData.count < 1 {
            return
        }
        
        resultsTable.deselectRow(at: indexPath, animated: true)
        
        let detailsVC = DetailsViewController()
        detailsVC.title = searchData[indexPath.row].placeName ?? "Result"
        detailsVC.fsqID = searchData[indexPath.row].fsqId ?? ""
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
