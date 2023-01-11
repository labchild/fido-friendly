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
/*
    var placeNameLabel: UILabel = {
        var placeNameLabel = UILabel()
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        return placeNameLabel
    }()
    let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = .systemFont(ofSize: 13, weight: .regular)
        return categoryLabel
    }()
    let ratingsLabel: UILabel = {
        let ratingsLabel = UILabel()
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsLabel.font = .systemFont(ofSize: 13, weight: .regular)
        return ratingsLabel
    }()
    let addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.font = .systemFont(ofSize: 16, weight: .regular)
        addressLabel.numberOfLines = 0
        return addressLabel
    }()
    let phoneNumberLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.font = .systemFont(ofSize: 16, weight: .regular)
        return phoneNumberLabel
    }()
    let websiteLabel: UILabel = {
        let websiteLabel = UILabel()
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.font = .systemFont(ofSize: 16, weight: .regular)
        return websiteLabel
    }()*/
    let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save for later", for: .normal)
        saveButton.configuration = .filled()
        saveButton.configuration?.baseBackgroundColor = .systemPink
        return saveButton
    }()
    var fsqID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(detailsView)
        detailsView.layoutSubviews()
        detailsView.fsqID = fsqID
        detailsView.placeNameLabel.text = detailsData?.placeName ?? ""
        detailsView.categoryLabel.text = detailsData?.categories?.first?.name ?? ""
        detailsView.ratingsLabel.text = "\(detailsData?.rating?.description ?? "-")/10"
        detailsView.addressLabel.text = detailsData?.location?.address ?? ""
        detailsView.phoneNumberLabel.text = "☎️ \(detailsData?.tel ?? "-")"
        detailsView.websiteLabel.text = "🌐 \(detailsData?.website ?? "-")"
        
        view.addSubview(saveButton)
        
        configureConstraints()
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        
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
        detailsView.fsqID = fsqID
        detailsView.placeNameLabel.text = detailsData?.placeName ?? ""
        detailsView.categoryLabel.text = detailsData?.categories?.first?.name ?? ""
        detailsView.ratingsLabel.text = "\(detailsData?.rating?.description ?? "-")/10"
        detailsView.addressLabel.text = detailsData?.location?.address ?? ""
        detailsView.phoneNumberLabel.text = "☎️ \(detailsData?.tel ?? "-")"
        detailsView.websiteLabel.text = "🌐 \(detailsData?.website ?? "-")"
    }

    func configureConstraints() {
        /*let placeNameLabelConstraints = [
            placeNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            placeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        let categoryLabelConstraints = [
            categoryLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7)
        ]
        let ratingsLabelConstraints = [
            ratingsLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 10),
            ratingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            ratingsLabel.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 10)
        ]
        let addressLabelConstraints = [
            addressLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        let phoneNumberLabelConstraints = [
            phoneNumberLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]*/
        let detailsViewConstraints = [
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9)
        ]
        let saveButtonConstraints = [
            saveButton.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 100),
            saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]

        /*NSLayoutConstraint.activate(placeNameLabelConstraints)
        NSLayoutConstraint.activate(categoryLabelConstraints)
        NSLayoutConstraint.activate(ratingsLabelConstraints)
        NSLayoutConstraint.activate(addressLabelConstraints)
        NSLayoutConstraint.activate(phoneNumberLabelConstraints)*/
        NSLayoutConstraint.activate(detailsViewConstraints)
        NSLayoutConstraint.activate(saveButtonConstraints)
    }
    
    // MARK: Actions
    @objc func handleSaveButtonTap() {
        print(self.title)
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
                print("Saved: \(placeName)")
                print("saved: \(fsqID)")
            } catch {
                print("Saving error: \(error)")
            }
        }
    }
}
