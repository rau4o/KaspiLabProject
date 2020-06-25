//
//  AddEntryController.swift
//  MyNotes
//
//  Created by rau4o on 6/18/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class AddEntryController: UIViewController {
    
    // MARK: - Properties
    
    var addEntryView = AddEntryView()
    var viewModel = AddEntryViewModel()
    var isCallSetUP = true
    var intSelected: Int?
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        addEntryView.dateTextField.delegate = self
        initialSetup()
        activateClosure()
    }
    
    // MARK: - Helper function
    
    private func activateClosure() {
        addEntryView.backButtonAction = { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true, completion: nil)
        }
        
        addEntryView.cameraAction = { [weak self] in
            guard let self = self else {return}
            self.present(self.addEntryView.imagePicker, animated: true, completion: nil)
        }
        
        viewModel.didFinishLoadData = { [weak self] in
            guard let self = self else {return}
            self.viewModel.textStoryViewModel = self.addEntryView.entryTextView.text
            self.viewModel.dateTextViewModel = self.addEntryView.dateText
        }
        
        addEntryView.saveAction = { [weak self] in
            guard let self = self else { return }
            let entryModel = EntryModel()
            
            entryModel.text = self.addEntryView.entryTextView.text
            let imagesArr = self.addEntryView.images
            for image in imagesArr {
                let pictureModel = Picture(image: image)
                entryModel.pictures.append(pictureModel)
                pictureModel.entry = entryModel
            }
            RealmService.shared.create(entryModel)
        
            self.dismiss(animated: true, completion: nil)
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
