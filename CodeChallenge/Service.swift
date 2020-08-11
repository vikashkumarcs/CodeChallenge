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
    
    func GetData(urlString: String, complitionHandler:@escaping ([DbModel])-> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        Alamofire.request(url, method: .get, parameters: [:]).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                print("Failed")
                return
            }
            
            guard let data = response.data else {
                print("No any records")
                return
            }
            
            do {
                let collection = try JSONDecoder().decode([DbModel].self, from: data)
                complitionHandler(collection)
                
            } catch {
                print("Error")
            }
            
        }
    }
}

