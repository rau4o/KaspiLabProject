//
//  LoginController.swift
//  MyNotes
//
//  Created by rau4o on 6/15/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Elements
    
    var loginView = LoginView()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    // MARK: - Helper fuction
    
    private func layoutUI() {
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
