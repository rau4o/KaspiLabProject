//
//  CollectionNotesViewModel.swift
//  MyNotes
//
//  Created by rau4o on 6/23/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation
import RealmSwift

class CollectionNotesViewModel {
    
    var entries: Results<EntryModel>?
    
    func numberOfItems() -> Int {
        entries?.count ?? 0
    }
    
    func getData(at index: Int) -> EntryModel {
        guard let entriesArr = entries else {return EntryModel()}
        return entriesArr[index]
    }
    
    func getEntries() {
        self.entries = RealmService.shared.realm.objects(EntryModel.self).sorted(byKeyPath: "date", ascending: false)
    }
}
