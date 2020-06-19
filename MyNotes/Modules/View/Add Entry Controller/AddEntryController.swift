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
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        initialSetup()
        activateClosure()
    }
    
    // MARK: - Helper function
    
    private func activateClosure() {
        addEntryView.backButtonAction = { [weak self] in
            guard let self = self else {return}
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
            make.edges.equalToSuperview()
        }
    }
}
