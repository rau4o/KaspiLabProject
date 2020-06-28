//
//  ProfileHeaderView.swift
//  MyNotes
//
//  Created by rau4o on 6/28/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class ProfileHeaderView: BaseView {
    
    // MARK: - Properties
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 75
        image.backgroundColor = .black
        return image
    }()
    
    // MARK: - Setup Views
    
    override func setupViews() {
        configureUI()
    }
    
    // MARK: - Helper Function
    
    private func configureUI() {
        addSubview(profileImage)
        
        profileImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
    }
    
}
