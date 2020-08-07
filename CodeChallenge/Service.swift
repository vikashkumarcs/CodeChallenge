//
//  Service.swift
//  WetherForcastApp
//
//  Created by Vikash on 05/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    func GetData(urlString: String, complitionHandler:@escaping (Any)-> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        Alamofire.request(url, method: .get, parameters: [:]).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            guard let value = response.result.value as? [Any] else {
                return
            }
            complitionHandler(value)
        }
    }
}

