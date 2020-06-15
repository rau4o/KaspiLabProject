//
//  LoginView.swift
//  MyNotes
//
//  Created by rau4o on 6/15/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: BaseView {
    
    // MARK: - Properties
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to my diary"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Medium", size: 40)
        return label
    }()
    
    private let preTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Start your entries here"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Medium", size: 27)
        return label
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "notebook")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContrainerView(image: UIImage(named: "student")!,
                                                textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
        tf.attributedPlaceholder = NSAttributedString(string: "Email",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 20)])
        tf.tintColor = .white
        return tf
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContrainerView(image: UIImage(named: "padlock")!,
                                                textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
        tf.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 20)])
        tf.tintColor = .white
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainBlue
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        return button
    }()
    
    lazy private var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Create account", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor.mainBlue]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleDontHaveAccount(_ :)), for: .touchUpInside)
        return button
    }()
    
    // ConfigureUI

    override func setupViews() {
        backgroundColor = .mainBlue
        layoutUI()
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        addSubview(backgroundImage)
        
        [loginButton, stackView, titleLabel, preTitleLabel].forEach {
            addSubview($0)
        }
        
        backgroundImage.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(70)
            make.left.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(30)
        }
        
        preTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(30)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(preTitleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
    }
    
    // MARK: - Selectors
    
    @objc private func handleDontHaveAccount(_ sender: UIButton) {
        
    }
}
