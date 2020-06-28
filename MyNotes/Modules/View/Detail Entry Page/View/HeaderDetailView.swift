//
//  HeaderDetailView.swift
//  MyNotes
//
//  Created by rau4o on 6/28/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class HeaderDetailView: BaseView {
    
    // MARK: - Properties
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    // MARK: - Setup Views

    override func setupViews() {
        configureUI()
    }
    
    // MARK: - Helper function
    
    private func configureUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
