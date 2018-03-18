//
//  ViewController+PullToRefresh.swift
//  TestApp
//
//  Created by Nancy Himanshu Sharma on 18/3/18.
//  Copyright © 2018 Nancy Himanshu Sharma. All rights reserved.
//

import Foundation

extension ViewController {
  
    // Add Refresh Control to Table View
    func addPullToRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = .blue
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Country Data...")
        refreshControl.addTarget(self, action: #selector(refreshCountryData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshCountryData(_ sender: Any) {
        fetchServerData()
    }
}
