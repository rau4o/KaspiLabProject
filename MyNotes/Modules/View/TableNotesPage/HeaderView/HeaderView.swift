//
//  HeaderView.swift
//  MyNotes
//
//  Created by rau4o on 6/17/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class HeaderView: BaseView {
    
    // MARK: - Properties
    
    var cameraAction: (() -> Void)?
    var plusAction: (() -> Void)?
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.addTarget(self, action: #selector(handlePlusAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "camera"), for: .normal)
        button.addTarget(self, action: #selector(handleCameraAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy private var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cameraButton, plusButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    // MARK: - Init
    
    override func setupViews() {
        layoutUI()
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Selectors
    
    @objc private func handlePlusAction(_ sender: UIButton) {
        plusAction?()
    }
    
    @objc private func handleCameraAction(_ sender: UIButton) {
        cameraAction?()
    }
}
