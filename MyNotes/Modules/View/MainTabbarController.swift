//
//  MainTabbarController.swift
//  MyNotes
//
//  Created by rau4o on 6/17/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class MainTabbarController: CustomTabbarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllers()
    }
    
    private func configureControllers() {
        let tableController = TableNotesController()
        let collectionController = CollectionNotesController()
//        let profileController = ProfileController()
        
        tableController.tabBarItem = UITabBarItem(title: "notes", image: UIImage(named: "menu"), tag: 0)
        collectionController.tabBarItem = UITabBarItem(title: "photos", image: UIImage(named: "collectionMenu"), tag: 1)
//        profileController.tabBarItem = UITabBarItem(title: "profile", image: UIImage(named: "user"), tag: 3)
        viewControllers = [tableController, collectionController]
    }
}
