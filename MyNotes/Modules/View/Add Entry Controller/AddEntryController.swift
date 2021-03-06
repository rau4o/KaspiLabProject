//
//  AddEntryController.swift
//  MyNotes
//
//  Created by rau4o on 6/18/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import MapKit

class AddEntryController: UIViewController {
    
    // MARK: - Properties
    
    var addEntryView = AddEntryView()
    var viewModel = AddEntryViewModel()
    var isCallSetUP = true
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialSetup()
        activateClosure()
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addEntryView.images.removeAll()
        addEntryView.entryTextView.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if addEntryView.startWithCamera {
            addEntryView.startWithCamera = false
            self.present(self.addEntryView.imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helper function
    
    private func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let startingYPos = UIApplication.shared.statusBarFrame.size.height
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: startingYPos, width: screenSize.width, height: 50))
        let navItem = UINavigationItem(title: "Publish new Entry")
        let backItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(backAction(_:)))
        let saveItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(saveAction(_:)))
        navItem.leftBarButtonItem = backItem
        navItem.rightBarButtonItem = saveItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    @objc func backAction(_ sender: UINavigationItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveAction(_ sender: UINavigationItem) {
        let entryModel = EntryModel()
        entryModel.text = self.addEntryView.entryTextView.text
        entryModel.address = self.addEntryView.addressLabel.text ?? "no address"
        let imagesArr = self.addEntryView.images
        for image in imagesArr {
            let pictureModel = Picture(image: image)
            entryModel.pictures.append(pictureModel)
            pictureModel.entry = entryModel
        }
        RealmService.shared.create(entryModel)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func activateClosure() {
        addEntryView.backButtonAction = { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true, completion: nil)
        }
        
        addEntryView.cameraAction = { [weak self] in
            guard let self = self else {return}
            self.present(self.addEntryView.imagePicker, animated: true, completion: nil)
        }
    }
}

// MARK: - ConfigureUI

private extension AddEntryController {
    
    func initialSetup() {
        layoutUI()
    }
    
    private func layoutUI() {
        view.addSubview(addEntryView)

        addEntryView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }
}
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
