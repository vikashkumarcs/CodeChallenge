//
//  ViewController.swift
//  TestAssignment
//
//  Created by Vikash on 05/08/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import UIKit
import SnapKit


class ViewController: UIViewController {

    // MARK: Properties
    var tableView: UITableView!
    var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModal: ViewModel = {
        let viewModal = ViewModel(services: APIService())
        return viewModal
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.intializer()
        self.setupActivityIndicator()
        self.fetchData()
        self.tableViewSetUp()
        self.customCellRegistration()
    }
    
    // MARK: Custom Methods
    func intializer()  {
        
        viewModal.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
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
    
    func tableViewSetUp() {
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view).inset(UIEdgeInsets(top: 50.0, left: 10.0, bottom: 0.0, right: 10.0))
        }
    }
    
    func customCellRegistration() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func fetchData() {
        viewModal.fetchData()
    }
    
}

// MARK: Tableview Delegate implemaintation
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        cell.cellConfiguration(cellInfo: viewModal.dataSource[indexPath.row], indexPath: indexPath)
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        let detailViewController = DetailViewController()
        detailViewController.customCell = cell
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

