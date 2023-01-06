//
//  ResultsViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit

class ResultsViewController: UIViewController {

    let resultsTable = UITableView()
    
    var searchData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...25 {
            searchData.append("Dog-Friendly Place \(i + 1)")
        }
        
        view.backgroundColor = .systemPurple
        view.addSubview(resultsTable)
        
        resultsTable.register(UITableViewCell.self,
                              forCellReuseIdentifier: "cell")
        resultsTable.delegate = self
        resultsTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultsTable.frame = view.bounds
    }


}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultsTable.deselectRow(at: indexPath, animated: true)
        print("cell \(indexPath.row + 1) tapped")
    }

}
