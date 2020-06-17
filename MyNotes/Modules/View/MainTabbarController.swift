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
        let vc = TableNotesController()
        let vc2 = WelcomeController()
        let vc3 = CollectionNotesController()
        
        viewControllers = [vc, vc2, vc3]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
