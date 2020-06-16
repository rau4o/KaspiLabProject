//
//  RegistrationView.swift
//  MyNotes
//
//  Created by rau4o on 6/15/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class RegistrationView: BaseView {
    
    // MARK: - Properties
    
    // MARK: - UI Elements
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var nameContainerView: UIView = {
        let view = UIView().inputContrainerView(image: UIImage(named: "student")!,
                                                textField: nameTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField().textField(withPlaceholder: "Name", isSecureTextEntry: false)
        tf.attributedPlaceholder = NSAttributedString(string: "Name",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 20)!])
        tf.tintColor = .white
        return tf
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
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 20)!])
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
        let tf = UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: false)
        tf.attributedPlaceholder = NSAttributedString(string: "Password",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 20)!])
        tf.tintColor = .white
        return tf
    }()
    
    lazy private var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameContainerView, emailContainerView, passwordContainerView])
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainBlue
        button.setTitle("Create account", for: .normal)
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        return button
    }()
    
    // MARK: - Setup Views
    
    override func setupViews() {
        layoutUI()
        backgroundColor = .mainBlue
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        [backgroundImage, stackView, registrationButton].forEach {
            addSubview($0)
        }
        
        backgroundImage.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(40)
            make.left.right.equalToSuperview().inset(30)
        }
        
        registrationButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
