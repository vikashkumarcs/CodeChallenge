//
//  SplashScreen.swift
//  CodeChallenge
//
//  Created by Vikash on 08/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController, DisplayActivityIndicator {
    
    let apiUrlString = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"

    var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGray
        setupActivityIndicator()
        
        if Connectivity.isConnectedToInternet {
            fetchDataFromServer()
        } else {
            print("Internet is not available")
            self.navigateToNextScreen()
        }
    }
    
    func setupActivityIndicator() {
        activityIndicator = showActivityIndicator()
        self.activityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Fetch data from the server
    func fetchDataFromServer() {
        
        let restService = APIService()
        restService.GetData(urlString: apiUrlString) { [weak self] (response) in
            
            let results = HelperDb.dbHelper.fetchAllItems(DbModel.self)
            HelperDb.dbHelper.deleteAllItems(results)
            
            var collection = response
            collection.sort {
                $0.type! < $1.type!
            }
            
            for dbModel in collection {
                self?.savedDataInDB(model: dbModel)
            }
            self?.navigateToNextScreen()
        }
    }
    
    // MARK: Saved Data in Relem Db
    func savedDataInDB(model:DbModel) {
        HelperDb.dbHelper.saveData(model)
    }
    
    func navigateToNextScreen() {
        hideActivityIndicator(activityIndicator: activityIndicator)
        let navigationController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as! UINavigationController
        navigationController.isNavigationBarHidden = false
        navigationController.view.backgroundColor = UIColor.white
        navigationController.setViewControllers([ViewController()], animated: false)
    }

}
