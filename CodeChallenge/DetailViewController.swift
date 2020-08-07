//
//  DetailViewController.swift
//  TestAssignment
//
//  Created by Vikash on 06/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: Properties
    var txtDescription: UITextView!
    var imageView: UIImageView!
    var txtDescString:String = ""
    var customCell:CustomCell!
    
    
    override func loadView() {
        super.loadView()
        self.view  = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view .backgroundColor = UIColor.lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUiConfiguration()
    }
    
    func setupUiConfiguration() {
        
        txtDescription = UITextView()
        txtDescription.text = customCell.txtDescriptionLabel.text //txtDescString
        self.view.addSubview(txtDescription)
        
        
        txtDescription.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(5)
            make.right.equalTo(self.view).offset(-5)
            make.top.equalTo(self.view).offset(64)
            make.bottom.equalToSuperview()
        }
        
        imageView = UIImageView()
        imageView.sizeToFit()
        imageView.image = customCell.displayImg.image
        self.view.addSubview(imageView)

        imageView.snp.makeConstraints { (make) in

            make.left.equalTo(self.view).offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(64)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        imageView.isHidden = true
        txtDescription.isHidden = true
        if customCell.typeLabel.text == "image" {
            imageView.isHidden = false
        } else {
            txtDescription.isHidden = false
        }
        
    }

}
