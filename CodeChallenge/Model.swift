//
//  Model.swift
//  TestAssignment
//
//  Created by Vikash on 05/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation
import RealmSwift

//struct CellModel {
//
//    var id:String?
//    var type:String?
//    var date1:String?
//    var data:String?
//
////    init(id: String, type: String, date: String, data: String) {
////        self.id = id
////        self.type = type
////        self.date = date
////        self.data = data
////    }
//
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        let id = try values.decode(String.self, forKey: .id)
////        let type = try values.decode(String.self, forKey: .type)
////        let date = try values.decode(String.self, forKey: .date)
////        let data = try values.decode(String.self, forKey: .data)
////
////
////        self.init(id: id, type: type, date: date, data: data)
////    }
//}

class DbModel: Object {
        
    @objc dynamic var id:String?
    @objc dynamic var type:String?
    @objc dynamic var date1:String?
    @objc dynamic var data:String?
    
}
