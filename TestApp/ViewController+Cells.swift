//
//  ViewController+Cells.swift
//  TestApp
//
//  Created by Nancy Himanshu Sharma on 14/3/18.
//  Copyright © 2018 Nancy Himanshu Sharma. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setUpCellIdentifiers() {
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        let nibName = UINib(nibName: "CountryTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "Cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CountryTableViewCell
        guard
            let data: Dictionary = modelData.response[indexPath.row] as? Dictionary<String, Any> else {
                return UITableViewCell()
        }
        cell?.setCellValues(title: data["title"] as? String ?? "", description: data["description"] as? String ?? "", imageUrl: data["imageHref"] as? String ?? "")
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let title = modelData.title else {
            return ""
        }
        return title
    }
}
