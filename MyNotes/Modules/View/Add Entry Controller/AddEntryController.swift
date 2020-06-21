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
        
        addEntryView.saveAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.saveEntry(entry: EntryModel())
            self.dismiss(animated: true, completion: nil)
        }
        
        viewModel.didFinishLoadData = { [weak self] in
            guard let self = self else {return}
            self.viewModel.textStoryViewModel = self.addEntryView.textDesc
            self.viewModel.dateTextViewModel = self.addEntryView.dateText
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
