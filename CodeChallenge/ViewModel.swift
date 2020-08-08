//
//  ViewModel.swift
//  TestAssignment
//
//  Created by Vikash on 05/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation


class ViewModel {

    var reloadTableViewClosure: (()->())?
    public private(set) var dataSource: [DbModel] = [DbModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var showAlertClosure: (()->())?
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    func fetchData() {
        let dbData = HelperDb.dbHelper.fetchAllItems(DbModel.self)
        if dbData.count > 0 {
            self.dataSource.removeAll()
            self.dataSource.append(contentsOf: dbData)
        } else {
            self.alertMessage = "No any record is available"
        }
    }
}
