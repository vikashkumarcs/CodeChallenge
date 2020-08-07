//
//  HelperDb.swift
//  TestAssignment
//
//  Created by Vikash on 06/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation
import RealmSwift

final class HelperDb {
    
    private let realm = try! Realm()
    static let dbHelper = HelperDb()
    
    private init() {
        print(realm.configuration.fileURL!)
    }
    
    // Saved item in DB
    func saveData<Element: Object>(_ item: Element) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    // Retrive all items from DB
    func fetchAllItems<Element: Object>(_ type: Element.Type) -> Results<Element>  {
        let results = realm.objects(type.self )
        return results
    }
    
    // Delete all items from DB
    func deleteAllItems<Element: Object>(_ objects: Results<Element>) {
        do {
            realm.beginWrite()
            realm.delete(objects)
            try realm.commitWrite()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
}
