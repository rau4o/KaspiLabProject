//
//  StaticLabelViewCell.swift
//  MyNotes
//
//  Created by rau4o on 6/28/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class StaticLabelViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let staticLocationLabel: UILabel = {
        let label = UILabel(font: UIFont.mediumSF, textAlignment: .left)
        return label
    }()
    
    internal let staticLocationImage: UIImageView = {
        let image = UIImageView()
//        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Function
    
    private func configureUI() {
        [staticLocationImage, staticLocationLabel].forEach {
            addSubview($0)
        }
        
        staticLocationImage.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.height.equalTo(15)
            make.width.equalTo(25)
        }
        
        staticLocationLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalTo(staticLocationImage.snp.right).offset(5)
            make.right.equalToSuperview()
        }
    }
    
    func configureCell() {
        staticLocationLabel.text = "Your Location📍"
        staticLocationImage.image = UIImage(named: "map-1")
    }
}
