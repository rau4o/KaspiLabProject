//
//  MainTabbarController.swift
//  MyNotes
//
//  Created by rau4o on 6/17/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import SOTabBar

class MainTabbarController: SOTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SOTabBarSetting.tabBarTintColor = #colorLiteral(red: 2.248547389e-05, green: 0.7047000527, blue: 0.6947537661, alpha: 1)
        SOTabBarSetting.tabBarBackground = .mainBlue
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 60, height: 60)
        configureControllers()
    }
    
    private func configureControllers() {
        let tableController = TableNotesController()
        let collectionController = CollectionNotesController()
        let addEntryController = AddEntryController()
        
        tableController.tabBarItem = UITabBarItem(title: "notes", image: UIImage(named: "menu"), tag: 0)
        collectionController.tabBarItem = UITabBarItem(title: "photos", image: UIImage(named: "collectionMenu"), tag: 1)
        addEntryController.tabBarItem = UITabBarItem(title: "add", image: UIImage(named: "plusIcon"), tag: 2)
        viewControllers = [tableController, addEntryController, collectionController]
    }
}
