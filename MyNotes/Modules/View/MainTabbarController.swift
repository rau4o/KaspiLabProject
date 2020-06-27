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
        let mapController = MapController()
        let calendarController = CalendarController()
        
        tableController.tabBarItem = UITabBarItem(title: "notes", image: UIImage(named: "menu"), tag: 0)
        collectionController.tabBarItem = UITabBarItem(title: "photos", image: UIImage(named: "collectionMenu"), tag: 1)
        mapController.tabBarItem = UITabBarItem(title: "map", image: UIImage(named: "map"), tag: 3)
        calendarController.tabBarItem = UITabBarItem(title: "calendar", image: UIImage(named: "calendar"), tag: 4)
        viewControllers = [tableController, collectionController, mapController, calendarController]
    }
}
