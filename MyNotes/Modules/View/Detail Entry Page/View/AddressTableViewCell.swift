//
//  AddressTableViewCell.swift
//  MyNotes
//
//  Created by rau4o on 6/28/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let addressLabel: UILabel = {
        let label = UILabel(font: UIFont.tinyMediumSF, textAlignment: .left)
        return label
    }()
    
    private let addressImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "store")
        image.contentMode = .scaleAspectFit
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
    
    // MARK: - Helper function
    
    private func configureUI() {
        addSubview(addressLabel)
        addSubview(addressImage)
        
        addressImage.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(10)
            make.height.equalTo(15)
            make.width.equalTo(25)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalTo(addressImage.snp.right).offset(5)
            make.right.equalToSuperview()
        }
    }
    
    func configureCell(with model: EntryModel) {
        DispatchQueue.main.async {
            self.addressLabel.text = model.address
        }
    }
}
