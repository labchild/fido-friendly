//
//  TabBarController.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/3/23.
//

import UIKit

class TabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navigation tab menu
        let tab1 = UINavigationController(rootViewController: HomeViewController())
        let tab2 = UINavigationController(rootViewController: SavedPlacesViewController())
        
        tab1.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        tab2.tabBarItem.image = UIImage(systemName: "heart")
        
        tab1.title = "Search"
        tab2.title = "Saved"
        
        tabBar.tintColor = .systemPink
        tabBar.unselectedItemTintColor = .systemCyan
        tabBar.isTranslucent = false
        tabBar.barTintColor = .secondarySystemBackground
        
        setViewControllers([tab1, tab2], animated: true)
    }
    
}
