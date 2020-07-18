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
    
    var cardView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var yearLabel: UILabel = {
        return UILabel(font: UIFont.mediumSF, textAlignment: .center)
    }()
    
    private lazy var monthLabel: UILabel = {
        return UILabel(font: UIFont.mediumSF, textAlignment: .center)
    }()
    
    private lazy var dayLabel: UILabel = {
        return UILabel(font: UIFont.largeMediumSF, textAlignment: .center)
    }()
    
    private lazy var photoImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var previewText: UITextView = {
        let text = UITextView()
        text.font = UIFont.tinyMediumSF
        text.isScrollEnabled = false
        text.isEditable = false
        text.isSelectable = true
        return text
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel(font: UIFont.tinyMediumSF, textAlignment: .left)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        bounds = bounds.inset(by: padding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        addSubview(cardView)
        [photoImageView, previewText, locationLabel, monthLabel, dayLabel, yearLabel].forEach {
            cardView.addSubview($0)
        }
        
        cardView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(5)
        }
        
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.top).inset(5)
            make.left.equalTo(cardView.snp.left).inset(5)
            make.bottom.equalTo(cardView.snp.bottom).inset(5)
            make.width.equalTo(100)
        }
        
        previewText.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.top).inset(5)
            make.left.equalTo(photoImageView.snp.right).offset(5)
            make.right.equalTo(monthLabel.snp.left)
            make.bottom.equalTo(dayLabel.snp.bottom)
        }

        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(yearLabel.snp.top)
            make.left.equalTo(photoImageView.snp.right).offset(5)
            make.right.equalTo(monthLabel.snp.left)
            make.height.equalTo(21)
        }

        monthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.top).inset(5)
            make.right.equalTo(cardView.snp.right).inset(5)
            make.height.equalTo(21)
            make.width.equalTo(60)
        }

        dayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp.bottom)
            make.right.equalTo(cardView.snp.right).inset(5)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }

        yearLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dayLabel.snp.bottom)
            make.bottom.equalTo(cardView.snp.bottom).inset(5)
            make.right.equalTo(cardView.snp.right).inset(5)
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
            self.locationLabel.text = "\(entryModel.address)"
        }
    }
}
