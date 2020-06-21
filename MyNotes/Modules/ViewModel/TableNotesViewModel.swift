//
//  TableNotesViewModel.swift
//  MyNotes
//
//  Created by rau4o on 6/21/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation
import RealmSwift

class TableNotesViewModel {
    
    var entries: Results<EntryModel>?

    func numberOfData() -> Int {
        return entries?.count ?? 0
    }
    
    func getData(at index: Int) -> EntryModel {
        guard let entriesArr = entries else { return EntryModel()}
        return entriesArr[index]
    }
    
    func deleteEntry(entry: EntryModel) {
        RealmService.shared.delete(entry)
    }
    
    func getEntries() {
        entries = RealmService.shared.realm.objects(EntryModel.self).sorted(byKeyPath: "date", ascending: false)
    }
}
