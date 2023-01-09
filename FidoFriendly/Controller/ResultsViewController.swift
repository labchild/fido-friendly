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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .systemPurple
        view.addSubview(resultsTable)
        
        resultsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        APICaller().getDogFriendlyResults(completion: { (Places) in
            self.searchData = Places.results
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

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchData?[indexPath.row].placeName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultsTable.deselectRow(at: indexPath, animated: true)
        print(searchData![indexPath.row])
        
        let detailsVC = DetailsViewController()
        detailsVC.title = searchData?[indexPath.row].placeName ?? "Unknown Name"
        detailsVC.placeNameLabel.text = searchData?[indexPath.row].placeName ?? "Unknown Name"
        detailsVC.categoryLabel.text = searchData?[indexPath.row].categories?[0].name ?? ""
        detailsVC.addressLabel.text = searchData?[indexPath.row].location?.address ?? ""
        detailsVC.phoneNumberLabel.text = searchData?[indexPath.row].tel ?? ""
        detailsVC.websiteLabel.text = searchData?[indexPath.row].website ?? ""
        detailsVC.ratingsLabel.text = searchData?[indexPath.row].rating?.description ?? ""
        navigationController?.pushViewController(detailsVC, animated: true)
        
    }

}
