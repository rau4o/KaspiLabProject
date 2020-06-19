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
    
    var backButtonAction: (() -> Void)?
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleContainerView: UIView = {
        let view = UIView().inputTitleContainer(textField: titleTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 20)!])
        tf.tintColor = .white
        tf.textAlignment = .center
        return tf
    }()
    
    private let blueCameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "blueCamera"), for: .normal)
        button.addTarget(self, action: #selector(handleBlueCameraTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [blueCameraButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - Setup Views
    
    override func setupViews() {
        layoutUI()
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        
        [scrollView, titleContainerView, backButton].forEach {
            addSubview($0)
        }
        scrollView.addSubview(stackView)
        
        titleContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(80)
            make.left.right.equalToSuperview().inset(100)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(50)
            make.height.width.equalTo(50)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(70)
            make.left.right.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { (make) in
            make.bottom.equalTo(scrollView.snp.bottom)
            make.top.equalTo(scrollView.snp.top)
            make.left.right.equalTo(scrollView.snp.bottom)
        }
    }
    
    // MARK: - Selectors
    
    @objc private func handleBackButton(_ sender: UIButton) {
        backButtonAction?()
    }
    
    @objc private func handleBlueCameraTapped(_ sender: UIButton) {
        print(123)
    }
}
