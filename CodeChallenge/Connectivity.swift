//
//  Connectivity.swift
//  WetherForcastApp
//
//  Created by Vikash on 05/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
