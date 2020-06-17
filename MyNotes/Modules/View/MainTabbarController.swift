//
//  MainTabbarController.swift
//  MyNotes
//
//  Created by rau4o on 6/17/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class MainTabbarController: CircleBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllers()
    }
    
    private func configureControllers() {
        let tableController = TableNotesController()
        let collectionController = CollectionNotesController()
        tableController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "menu"), tag: 0)
        collectionController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "collectionMenu"), tag: 1)
        viewControllers = [tableController, collectionController]
    }
}