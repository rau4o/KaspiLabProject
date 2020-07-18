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
    var addressViewModel: String?
    var didFinishLoadData: (() -> Void)?
    
    func saveEntry() {
        RealmService.shared.create(entryModel ?? EntryModel())
    }
    
    func setupEntryModel(with entryModel: EntryModel) {
        DispatchQueue.main.async {
            self.textStoryViewModel = entryModel.text
            self.addressViewModel = entryModel.address
            let imagesArr = self.imagesData
            for image in imagesArr {
                let pictureModel = Picture(image: image)
                entryModel.pictures.append(pictureModel)
                pictureModel.entry = entryModel
            }
//            RealmService.shared.create(entryModel)
        }
    }
}

