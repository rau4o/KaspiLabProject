//
//  RegistrationController.swift
//  MyNotes
//
//  Created by rau4o on 6/15/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Elements
    
    var registrationView = RegistrationView()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        view.addSubview(registrationView)
        
        registrationView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
