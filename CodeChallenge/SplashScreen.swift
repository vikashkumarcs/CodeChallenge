//
//  SplashScreen.swift
//  CodeChallenge
//
//  Created by Vikash on 08/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController {

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
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        self.view.addSubview(activityIndicator)
        activityIndicator.layer.zPosition = 1
        
        activityIndicator.color = UIColor.black
        activityIndicator.startAnimating()
        
        activityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Fetch data from the server
    func fetchDataFromServer() {
        
        let restService = APIService()
        restService.GetData(urlString: apiUrlString) {[weak self] (response) in
            
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
            
            let results = HelperDb.dbHelper.fetchAllItems(DbModel.self)
            HelperDb.dbHelper.deleteAllItems(results)
            
            for model in collection {
                self?.savedDataInDB(model: model)
            }
            
            self?.navigateToNextScreen()
        }
    }
    
    // MARK: Saved Data in Relem Db
    func savedDataInDB(model:DbModel) {
        HelperDb.dbHelper.saveData(model)
    }
    
    func navigateToNextScreen() {
        self.activityIndicator.stopAnimating()
        let navigationController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as! UINavigationController
        navigationController.isNavigationBarHidden = false
        navigationController.view.backgroundColor = UIColor.white
        navigationController.setViewControllers([ViewController()], animated: false)
    }

}
