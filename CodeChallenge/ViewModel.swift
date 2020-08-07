//
//  ViewModel.swift
//  TestAssignment
//
//  Created by Vikash on 05/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation


class ViewModel {

    private let restService: APIService
    var reloadTableViewClosure: (()->())?
    
    public private(set) var dataSource: [DbModel] = [DbModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    init(services:APIService) {
        self.restService = services
    }
    
    func fetchData() {
        let dbData = HelperDb.dbHelper.fetchAllItems(DbModel.self)
        self.dataSource.removeAll()
        self.dataSource.append(contentsOf: dbData)
    }
}
