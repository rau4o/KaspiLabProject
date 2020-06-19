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
    
    let vc = MainTabbarController()
    
    // MARK: - UI Elements
    
    var loginView = LoginView()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        activateClosure()
    }
    
    // MARK: - Helper fuction
    
    private func layoutUI() {
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func activateClosure() {
        loginView.loginAction = { [weak self] in
            guard let self = self else {return}
            self.loginView.loginButton.startAnimation()
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                sleep(1)
                DispatchQueue.main.async(execute: { () -> Void in
                    self.loginView.loginButton.stopAnimation(animationStyle: .expand, completion: { [weak self] in
                        guard let self = self else { return }
//                        self.changeVC(vc: SceneDelegate.shared.getConfiguredController())
                        self.vc.modalPresentationStyle = .fullScreen
                        self.vc.modalTransitionStyle = .crossDissolve
                        self.present(self.vc, animated: true, completion: nil)
                    })
                })
            })
        }
    }
}
