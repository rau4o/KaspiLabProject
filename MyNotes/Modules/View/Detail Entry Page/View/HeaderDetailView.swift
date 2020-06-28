//
//  HeaderDetailView.swift
//  MyNotes
//
//  Created by rau4o on 6/28/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class HeaderDetailView: UITableViewCell {
    
    // MARK: - Properties
    
    let mainImageView: UIImageView = {
        let image = UIImageView()
//        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Setup Views
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper function
    
    private func configureUI() {
        [mainImageView].forEach {
            addSubview($0)
        }
        mainImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func configureDetailView(with model: EntryModel) {
        mainImageView.image = model.pictures.first?.thumbnail()
    }
}
