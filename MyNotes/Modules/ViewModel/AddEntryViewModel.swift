//
//  AddEntryViewModel.swift
//  MyNotes
//
//  Created by rau4o on 6/20/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import RealmSwift

class AddEntryViewModel {
    
    var entryModel: EntryModel? {
        didSet {
            guard let entryModel = entryModel else {return}
            setupEntryModel(with: entryModel)
            didFinishLoadData?()
        }
    }
    
    var imagesData: [UIImage] = []
    var textStoryViewModel: String?
    var dateTextViewModel: String?
    var didFinishLoadData: (() -> Void)?
    
    func saveEntry(entry: EntryModel) {
        RealmService.shared.create(entry, completion: {
            self.entryModel = entry
        })
//        RealmService.shared.create(entry) { (entry) -> Object in
//            self.entryModel = entry
//            guard let entry = self.entryModel else {return Object()}
//            return entry
//        }
    }
    
    private func setupEntryModel(with entryModel: EntryModel) {
        DispatchQueue.main.async {
            self.textStoryViewModel = entryModel.text
            self.dateTextViewModel = entryModel.datePrettyString()
            for image in self.imagesData {
                let pictureModel = Picture(image: image)
                entryModel.pictures.append(pictureModel)
                pictureModel.entry = entryModel
            }
        }
    }
}

