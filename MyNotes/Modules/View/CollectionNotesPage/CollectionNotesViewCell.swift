//
//  CollectionNotesViewCell.swift
//  MyNotes
//
//  Created by rau4o on 6/17/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class CollectionNotesViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let dayLabel: UILabel = {
        let label = UILabel(font: .enormousMediumSF, textAlignment: .right)
        label.textColor = .white
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel(font: .mediumSF, textAlignment: .right)
        label.textColor = .white
        return label
    }()
    
    private var photoImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        return image
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        [photoImageView, monthLabel, dayLabel].forEach {
            addSubview($0)
        }
        
        photoImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        monthLabel.snp.makeConstraints { (make) in
            make.left.equalTo(photoImageView.snp.left)
            make.bottom.equalTo(photoImageView.snp.bottom)
            make.right.equalTo(photoImageView.snp.right)
            make.height.equalTo(20)
        }
        
        dayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(monthLabel.snp.left)
            make.bottom.equalTo(monthLabel.snp.top)
            make.right.equalTo(monthLabel.snp.right)
            make.height.equalTo(50)
        }
    }
    
    func configureCell(entryModel: EntryModel) {
        
    }
}
