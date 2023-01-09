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
        
        resultsTable.register(UITableViewCell.self,
                              forCellReuseIdentifier: "cell")
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        
//        APICaller().getOneDogFriendlyResult(with: "49c4489df964a520b9561fe3", completion: { (place) in
//            self.searchData = place
//            DispatchQueue.main.async {
//                self.resultsTable.reloadData()
//            }
//        })
        
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
        return searchData?.count  ?? 1
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
        detailsVC.title = searchData?[indexPath.row].placeName
        navigationController?.pushViewController(detailsVC, animated: true)
        
    }

}
