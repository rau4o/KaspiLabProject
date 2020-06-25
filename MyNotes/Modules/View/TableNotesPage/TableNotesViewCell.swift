//
//  TableNotesViewCell.swift
//  MyNotes
//
//  Created by rau4o on 6/17/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class TableNotesViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let yearLabel: UILabel = {
        return UILabel(font: UIFont.mediumSF, textAlignment: .center)
    }()
    
    let monthLabel: UILabel = {
        return UILabel(font: UIFont.mediumSF, textAlignment: .center)
    }()
    
    let dayLabel: UILabel = {
        return UILabel(font: UIFont.largeMediumSF, textAlignment: .center)
    }()
    
    let photoImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.backgroundColor = .red
        return image
    }()
    
    let previewText: UITextView = {
        let text = UITextView()
        text.font = UIFont.tinyMediumSF
        return text
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        [photoImageView, previewText, monthLabel, dayLabel, yearLabel].forEach {
            addSubview($0)
        }
        
        photoImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(5)
            make.width.equalTo(100)
        }
        
        previewText.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalTo(photoImageView.snp.right).offset(5)
            make.right.equalTo(monthLabel.snp.left)
        }
        
        monthLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(5)
            make.height.equalTo(21)
            make.width.equalTo(60)
        }

        dayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom)
            make.right.equalToSuperview().inset(5)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }

        yearLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dayLabel.snp.bottom)
            make.bottom.right.equalToSuperview().inset(5)
            make.width.equalTo(60)
        }
    }
    
    func configureCell(entryModel: EntryModel) {
        DispatchQueue.main.async {
            if let imageUrl = entryModel.pictures.first?.thumbnail() {
                self.photoImageView.image = imageUrl
            }
            self.dayLabel.text = entryModel.dayPrettyString()
            self.monthLabel.text = entryModel.monthPrettyString()
            self.yearLabel.text = entryModel.yearPrettyString()
            self.previewText.text = entryModel.text
        }
    }
}
