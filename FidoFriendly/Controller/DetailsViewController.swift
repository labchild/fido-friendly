//
//  DetailsViewController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/5/23.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    var detailsData: DogFriendlyPlace?
    var detailsView: DetailsView = {
        let view = DetailsView()
        return view
    }()

    let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save for later", for: .normal)
        saveButton.configuration = .filled()
        saveButton.configuration?.baseBackgroundColor = .systemPink
        return saveButton
    }()
    var fsqID = String()
    var addressString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        view.addSubview(detailsView)
        detailsView.layoutSubviews()
        /*detailsView.fsqID = fsqID
        detailsView.placeNameLabel.text = detailsData?.placeName ?? ""
        detailsView.categoryLabel.text = detailsData?.categories?.first?.name ?? ""
        detailsView.ratingsLabel.text = "\(detailsData?.rating?.description ?? "-")/10"
        detailsView.addressLabel.text = detailsData?.location?.address ?? ""
        detailsView.phoneNumberLabel.text = "☎️ \(detailsData?.tel ?? "-")"
        detailsView.websiteLabel.text = "🌐 \(detailsData?.website ?? "-")"
        */
        view.addSubview(saveButton)
        
        configureConstraints()
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.backgroundColor = .systemGreen
        
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
        
        APIManager.shared.getOneDogFriendlyResult(fsqID: fsqID) { place in
            self.detailsData = place
            DispatchQueue.main.async {
                self.detailsView.reloadInputViews()
                self.viewDidLayoutSubviews()
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        // format address string into something redable
        addressString = FormatHelper.shared.formatToMultiLineAddress(location: detailsData?.location)
        
        detailsView.fsqID = fsqID
        detailsView.placeNameLabel.text = detailsData?.placeName ?? ""
        detailsView.categoryLabel.text = detailsData?.categories?.first?.name ?? ""
        detailsView.ratingsLabel.text = "\(detailsData?.rating?.description ?? "-")/10"
        detailsView.addressLabel.text = addressString
        detailsView.phoneNumberLabel.text = "☎️ \(detailsData?.tel ?? "-")"
        detailsView.websiteLabel.text = "🌐 \(detailsData?.website ?? "-")"
    }

    func configureConstraints() {
        
        let detailsViewConstraints = [
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9)
        ]
        let saveButtonConstraints = [
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]

        NSLayoutConstraint.activate(detailsViewConstraints)
        NSLayoutConstraint.activate(saveButtonConstraints)
    }
    
    // MARK: Actions
    @objc func handleSaveButtonTap() {
        let id = self.fsqID
        if let placeName = self.title {
            savePlace(placeName: placeName, fsqID: id)
        }
    }
}

// MARK: Extensions: Core Data
extension DetailsViewController {
    func savePlace(placeName: String, fsqID: String) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "TestEntity", in: context) else { return }
            
            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)
            newValue.setValue(placeName, forKey: "placeName")
            newValue.setValue(fsqID, forKey: "fsqID")
            
            do {
                try context.save()
            } catch {
                print("Saving error: \(error)")
            }
        }
    }
}
