//
//  CustomCell.swift
//  SnapKitDemoProj
//
//  Created by Vikash on 05/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class CustomCell: UITableViewCell {

    
    // MARK: Properties
    static let identifier: String = "CustomCell_identifier"
    var idLabel: UILabel!
    var typeLabel: UILabel!
    var dateLabel: UILabel!
    var txtDescriptionLabel: UILabel!
    var displayImg: UIImageView!
    
    var viewContainer: UIView!
    var viewTop: UIView!
    

    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUIConfigure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Reset UI for resuseable
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.idLabel.text = nil
        self.typeLabel.text = nil
        self.dateLabel.text = nil
        self.dateLabel.text = nil
        self.txtDescriptionLabel.text = nil
        self.displayImg.image = nil
        self.txtDescriptionLabel.isHidden = true
        self.displayImg.isHidden = true
        
    }
    
    // MARK: Custom Methods
    func setUIConfigure() {
        
        viewContainer = UIView()
        self.addSubview(viewContainer)
        viewContainer.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0))
        }
        
        viewTop = UIView()
        viewContainer.addSubview(viewTop)
        viewTop.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(40)
        }
        
        idLabel = UILabel()
        viewTop.addSubview(idLabel)
        
        idLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(100)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        typeLabel = UILabel()
        typeLabel.textAlignment = .center
        viewTop.addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(105)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.center.equalTo(viewTop)
        }
        
        dateLabel = UILabel()
        dateLabel.textAlignment = .right
        viewTop.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        txtDescriptionLabel = UILabel()
        txtDescriptionLabel.numberOfLines = 0
        txtDescriptionLabel.isHidden = true
        contentView.addSubview(txtDescriptionLabel)
        
        txtDescriptionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(contentView).offset(40)
            make.bottom.equalToSuperview()
        }
        
        displayImg = UIImageView()
        displayImg.contentMode = .scaleAspectFit
        displayImg.isHidden = true
        contentView.addSubview(displayImg)
        
        displayImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(contentView).offset(40)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: cell Configuration Method
    func cellConfiguration(cellInfo: DbModel, indexPath:IndexPath) {
        
        self.idLabel.text = cellInfo.id ?? "NA"
        self.typeLabel.text = cellInfo.type ?? "NA"
        self.dateLabel.text = cellInfo.date1 ?? "NA"
        self.txtDescriptionLabel.text = cellInfo.data ?? "NA"
        
        if cellInfo.type == "image" {
            displayImg.isHidden = false
            
            let imageURL = URL(string: cellInfo.data!)!
            displayImg.sd_setImage(with: imageURL) {[weak self] (image, error, cache, urls) in
                if (error != nil) {
                    // Failed to load image
                    self?.displayImg.image = UIImage(named: "ico_placeholder")
                    print("Image not available")
                } else {
                    // Successful in loading image
                    self?.displayImg.image = image
                }
            }
            

        } else {
            txtDescriptionLabel.isHidden = false
        }
    }
    
}
