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
    
    var viewModel = AddEntryViewModel()
    var imagePicker = UIImagePickerController()
    var backButtonAction: (() -> Void)?
    var cameraAction: (() -> Void)?
    var saveAction: (() -> Void)?
    
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
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "blueCamera"), for: .normal)
        button.addTarget(self, action: #selector(handleBlueCameraTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cameraButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(handleSaveAction(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Setup Views
    
    override func setupViews() {
        layoutUI()
        imagePicker.delegate = self
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        
        [scrollView, titleContainerView, backButton].forEach {
            addSubview($0)
        }
        scrollView.addSubview(stackView)
        
        titleContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(100)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(20)
            make.height.width.equalTo(50)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
        }
        
        cameraButton.snp.makeConstraints { (make) in
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
    }
    
    // MARK: - Selectors
    
    @objc private func handleBackButton(_ sender: UIButton) {
        backButtonAction?()
    }
    
    @objc private func handleBlueCameraTapped(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        cameraAction?()
    }
    
    @objc private func handleSaveAction(_ sender: UIButton) {
        saveAction?()
    }
}

// MARK: - UIImagePickerControllerDelegate

extension AddEntryView: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let choosenImage = info[.originalImage] as? UIImage {
            viewModel.imagesData.append(choosenImage)
            let imageView = UIImageView()
            imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            imageView.image = choosenImage
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            stackView.addArrangedSubview(imageView)
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension AddEntryView: UINavigationControllerDelegate {
    
}
