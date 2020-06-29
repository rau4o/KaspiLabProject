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

private let cellId = "cell"

class AddEntryView: BaseView {
    
    // MARK: - Properties
    
    var viewModel = AddEntryViewModel()
    var imagePicker = UIImagePickerController()
    var backButtonAction: (() -> Void)?
    var cameraAction: (() -> Void)?
    var showLocationAction: (() -> Void)?
    var showPhotoLibrary: (() -> Void)?
    var images: [UIImage] = []
    var placemarks: [MKPlacemark] = []
    var coordinateData: [CLLocationCoordinate2D] = []
    var startWithCamera = false
//    var resultLocations: ((CLLocationCoordinate2D) -> Void)?
    var long: Double?
    var lat: Double?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    lazy var locationInputTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter your location"
        text.backgroundColor = .lightGray
        text.delegate = self
        return text
    }()
    
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
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        label.backgroundColor = .lightGray
        return label
    }()
    
    let secondAddress: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        label.backgroundColor = .lightGray
        return label
    }()
    
    // MARK: - Setup Views
    
    override func setupViews() {
        layoutUI()
        imagePicker.delegate = self
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        
        [addPhotoButton, entryTextView, separatorLine, locationInputTextField, addressLabel, secondAddress, tableView].forEach {
            addSubview($0)
        }
        
        addPhotoButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(65)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(80)
            make.width.equalTo(80)
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
        
        locationInputTextField.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLine.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationInputTextField.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(25)
        }
        
        secondAddress.snp.makeConstraints { (make) in
            make.top.equalTo(addressLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(25)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(secondAddress.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview().inset(10)
        }
    }
    
    func searchBy(naturalLanguageQuery: String, completion: @escaping([MKPlacemark]) -> Void) {
        var results = [MKPlacemark]()
        let request = MKLocalSearch.Request()
//        request.region = mapView.region
        request.naturalLanguageQuery = naturalLanguageQuery
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else { return }
            
            response.mapItems.forEach { (item) in
                results.append(item.placemark)
            }
            completion(results)
        }
    }
    
    // MARK: - Selectors
    
    @objc private func handleBackButton(_ sender: UIButton) {
        backButtonAction?()
    }
    
    @objc private func handleSaveAction(_ sender: UIButton) {
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
            addPhotoButton.setImage(choosenImage.withRenderingMode(.alwaysOriginal), for: .normal)
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension AddEntryView: UINavigationControllerDelegate {
    // activate UIImagePicker
}

// MARK: - UITableViewDelegate

extension AddEntryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placemark = placemarks[indexPath.row]
//        addressLabel.text = "\(placemark.coordinate.latitude)"
//        secondAddress.text = "\(placemark.coordinate.longitude)"
        addressLabel.text = "\(placemark.title!)"
//        long = placemark.coordinate.longitude
//        lat = placemark.coordinate.latitude
//        resultLocations = placemark.coordinate
//        resultLocations?(placemark.coordinate)
//        placemark.coordinate = placemark.coordinate
//        print(placemark.address)
    }
}

// MARK: - UITableViewDataSource

extension AddEntryView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placemarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: LocationCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? LocationCell {
            cell.placemark = placemarks[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
// MARK: - UITextFieldDelegate

extension AddEntryView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let query = textField.text else { return false }
        searchBy(naturalLanguageQuery: query) { [weak self] (results) in
            guard let self = self else {return}
            self.placemarks = results
            self.tableView.reloadData()
        }
        return true
    }
}

