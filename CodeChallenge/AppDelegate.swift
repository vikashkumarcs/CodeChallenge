//
//  AppDelegate.swift
//  CodeChallenge
//
//  Created by Vikash on 07/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let apiUrlString = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if Connectivity.isConnectedToInternet {
            fetchDataFromServer()
            sleep(3)
        } else {
            print("Internet is not available")
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: Fetch data from the server
    func fetchDataFromServer() {
        
        let restService = APIService()
        restService.GetData(urlString: apiUrlString) { (response) in
            
            guard let json = response as?  [Any] else {
                return
            }
            
            var collection = [DbModel]()
            for item in json {
                let json = item as? [String:Any]
                
                let model = DbModel()
                
                if let id = json?["id"],
                    let comments = id as? String {
                    model.id = comments
                }
                
                if let type = json?["type"],
                    let comments = type as? String {
                    model.type = comments
                }
                
                if let date = json?["date"],
                    let comments = date as? String {
                    model.date1 = comments
                }
                
                if let data = json?["data"],
                    let comments = data as? String {
                    model.data = comments
                }
                collection.append(model)
                collection.sort {
                    $0.type! < $1.type!
                }
            }
            
            for model in collection {
                self.savedDataInDB(model: model)
            }
        }
    }
    
    // MARK: Saved Data in Relem Db
    func savedDataInDB(model:DbModel) {
        HelperDb.dbHelper.saveData(model)
    }
    
}

