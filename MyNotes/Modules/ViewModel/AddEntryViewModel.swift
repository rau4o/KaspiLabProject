//
//  AddEntryViewModel.swift
//  MyNotes
//
//  Created by rau4o on 6/20/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class AddEntryViewModel {
    
    private var entryModel: EntryModel? {
        didSet {
            guard let entryModel = entryModel else {return}
            setupEntryModel(with: entryModel)
            didFinishLoadData?()
        }
    }
    
    var imagesData: [UIImage] = []
    var textStoryViewModel: String?
    var dateViewModel: Date?
    var didFinishLoadData: (() -> Void)?
    
    func saveEntry(entry: EntryModel) {
        self.entryModel = entry
        RealmService.shared.create(entry)
    }
    
    private func setupEntryModel(with entryModel: EntryModel) {
        textStoryViewModel = entryModel.text
        dateViewModel = entryModel.date
        for image in imagesData {
            let pictureModel = Picture(image: image)
            entryModel.pictures.append(pictureModel)
            pictureModel.entry = entryModel
        }
    }
}

