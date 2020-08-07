//
//  Model.swift
//  TestAssignment
//
//  Created by Vikash on 05/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation
import RealmSwift

class DbModel: Object {
        
    @objc dynamic var id:String?
    @objc dynamic var type:String?
    @objc dynamic var date1:String?
    @objc dynamic var data:String?
    
}
