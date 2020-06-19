//
//  AddEntryView.swift
//  MyNotes
//
//  Created by rau4o on 6/19/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class AddEntryView: BaseView {
    
    // MARK: - Properties
    
    private lazy var titleContainerView: UIView = {
        let view = UIView().inputContrainerView(image: UIImage(named: "student")!,
                                                textField: titleTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField().textField(withPlaceholder: "Title", isSecureTextEntry: false)
        tf.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 20)!])
        tf.tintColor = .white
        return tf
    }()
    
    // MARK: - Setup Views
    
    override func setupViews() {
        layoutUI()
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        [titleContainerView].forEach {
            addSubview($0)
        }
        
        titleContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(70)
            
        }
    }
}
