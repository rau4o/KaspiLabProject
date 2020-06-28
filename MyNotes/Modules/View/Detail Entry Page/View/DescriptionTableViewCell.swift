//
//  DescriptionTableViewCell.swift
//  MyNotes
//
//  Created by rau4o on 6/28/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy private var entryTextView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.isScrollEnabled = false
        text.font = UIFont(name: "SFProDisplay-Medium", size: 17)
        return text
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
        addSubview(entryTextView)
        
        entryTextView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(with model: EntryModel) {
        DispatchQueue.main.async {
            self.entryTextView.text = model.text
        }
    }
}
