//
//  RealmService.swift
//  MyNotes
//
//  Created by rau4o on 6/17/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import RealmSwift

class RealmService {
    
    // MARK: - Properties
    
    static let shared = RealmService()
    var realm = try! Realm()
    
    private init() {}
    
    func create<T: Object>(_ object: T) {
        do {
            try! realm.write {
                realm.add(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
