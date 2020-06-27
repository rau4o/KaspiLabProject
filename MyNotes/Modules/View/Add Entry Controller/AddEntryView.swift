//
//  AddEntryView.swift
//  MyNotes
//
//  Created by rau4o on 6/19/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import Photos
import MapKit

class AddEntryView: BaseView {
    
    // MARK: - Properties
    
    var viewModel = AddEntryViewModel()
    var imagePicker = UIImagePickerController()
    var backButtonAction: (() -> Void)?
    var cameraAction: (() -> Void)?
    var saveAction: (() -> Void)?
    var showLocationAction: (() -> Void)?
    var showPhotoLibrary: (() -> Void)?
    var images: [UIImage] = []
    let placemarks: [MKPlacemark] = []
    var startWithCamera = false
    
    var textDesc: String = "" {
        didSet {
            entryTextView.text = textDesc
        }
    }
    
    var dateText: String = "" {
        didSet {
            dateTextField.text = dateText
        }
    }
    
    let addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleShowImagePickerView(_:)), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
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
    
    let entryTextView: UITextView = {
        let text = UITextView()
        text.backgroundColor = .purple
        text.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        return text
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        return datePicker
    }()
    
    let dateTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .black
        text.textColor = .white
        text.font = UIFont(name: "SFProDisplay-Medium", size: 25)
        return text
    }()
    
    let locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("location", for: .normal)
        button.addTarget(self, action: #selector(handleShowLocationAction(_:)), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    
    let imageView = UIImageView()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    // MARK: - Setup Views
    
    override func setupViews() {
        layoutUI()
        imagePicker.delegate = self
        dateTextField.isHidden = true
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        
        [addPhotoButton,entryTextView, separatorLine].forEach {
            addSubview($0)
        }
        
        addPhotoButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(65)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        
        entryTextView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalTo(addPhotoButton.snp.right).offset(20)
            make.height.equalTo(100)
            make.right.equalToSuperview().inset(10)
        }
        
        separatorLine.snp.makeConstraints { (make) in
            make.height.equalTo(0.8)
            make.left.right.equalToSuperview()
            make.top.equalTo(entryTextView.snp.bottom).offset(10)
        }
        
//        [scrollView, titleContainerView, backButton, entryTextView, saveButton, cameraButton,dateTextField].forEach {
//            addSubview($0)
//        }
        
        
//        scrollView.addSubview(stackView)
//
//        titleContainerView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().inset(50)
//            make.left.right.equalToSuperview().inset(80)
//        }
//
//        backButton.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().inset(30)
//            make.top.equalToSuperview().inset(20)
//            make.height.width.equalTo(50)
//        }
//
//        saveButton.snp.makeConstraints { (make) in
//            make.right.equalToSuperview().inset(30)
//            make.top.equalToSuperview().inset(20)
//            make.height.width.equalTo(50)
//        }
//
//        entryTextView.snp.makeConstraints { (make) in
//            make.top.equalTo(titleTextField.snp.bottom).offset(50)
//            make.left.right.equalToSuperview().inset(50)
//            make.height.equalTo(150)
//        }
//
//        dateTextField.snp.makeConstraints { (make) in
//            make.top.equalTo(entryTextView.snp.bottom).offset(30)
//            make.left.right.equalToSuperview().inset(50)
//            make.height.equalTo(50)
//        }
//
//        scrollView.snp.makeConstraints { (make) in
//            make.bottom.equalTo(cameraButton.snp.top)
//            make.height.equalTo(70)
//            make.width.equalToSuperview()
//            make.left.right.equalToSuperview()
//        }
//
//        stackView.snp.makeConstraints { (make) in
//            make.edges.equalTo(scrollView)
//        }
//
//        cameraButton.snp.makeConstraints { (make) in
//            make.top.equalTo(scrollView.snp.bottom).offset(5)
//            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(50)
//        }
    }
    
    // MARK: - Selectors
    
    @objc private func handleBackButton(_ sender: UIButton) {
        backButtonAction?()
    }
    
    @objc private func handleSaveAction(_ sender: UIButton) {
        saveAction?()
        images.removeAll()
        entryTextView.text = ""
        stackView.removeFullyAllArrangedSubviews()
    }
    
    @objc private func handleShowLocationAction(_ sender: UIButton) {
        showLocationAction?()
    }
    
    @objc private func handleShowImagePickerView(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        cameraAction?()
    }
}

// MARK: - UIImagePickerControllerDelegate

extension AddEntryView: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let choosenImage = info[.originalImage] as? UIImage {
            images.append(choosenImage)
            imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            imageView.image = choosenImage
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            stackView.addArrangedSubview(imageView)
            addPhotoButton.setImage(choosenImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                print("============> \(asset.location?.coordinate.longitude ?? 0) \(asset.location?.coordinate.latitude ?? 0)")
            }
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension AddEntryView: UINavigationControllerDelegate {
    // activate UIImagePicker
}
