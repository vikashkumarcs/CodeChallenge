//
//  DisplayableView.swift
//  CodeChallenge
//
//  Created by Vikash on 11/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import Foundation
import UIKit

protocol DisplayAlert {
    func disPlayAlert(title: String, message: String)
}

protocol DisplayActivityIndicator {
    func showActivityIndicator() -> UIActivityIndicatorView
    func hideActivityIndicator(activityIndicator: UIActivityIndicatorView)
}

extension DisplayAlert where Self: UIViewController {

    func disPlayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}

extension DisplayActivityIndicator where Self: UIViewController {

     func showActivityIndicator()  -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        self.view.addSubview(activityIndicator)
        activityIndicator.layer.zPosition = 1
        
        activityIndicator.color = UIColor.black
        activityIndicator.startAnimating()
        return activityIndicator
        
    }

    func hideActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
    }
}
