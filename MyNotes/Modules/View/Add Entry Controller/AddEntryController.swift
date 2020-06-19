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
    
//    var addEntryView = AddEntryView()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - ConfigureUI

private extension AddEntryController {
    
    func initialSetup() {
        layoutUI()
    }
    
    private func layoutUI() {
//        view.addSubview(addEntryView)
//
//        addEntryView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
    }
}
