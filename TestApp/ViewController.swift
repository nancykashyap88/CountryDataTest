//
//  ViewController.swift
//  TestApp
//
//  Created by Nancy Himanshu Sharma on 13/3/18.
//  Copyright © 2018 Nancy Himanshu Sharma. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var model = CountryTableModel()
    var modelData = CountryData()
    
    var rows: Int {
        return modelData.response.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchServerData()   /* Fetch server data from api  */
        setUpCellIdentifiers() /* Set up cell identifiers */
        addPullToRefreshControl()  /* Add pull to refresh functionality */
    }
    
    func fetchServerData() {
        
        let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        Alamofire.request(url).responseData { (resData) -> Void in
            print(resData.result.value!)
            let jsonString = String(data : resData.result.value!, encoding : String.Encoding.ascii)
            if let data = jsonString?.data(using: String.Encoding.ascii, allowLossyConversion: true) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(json)
                    guard
                        let responseJSON = json as? [String: Any],
                        let results = responseJSON["rows"] as? [[String: Any]],
                        let title = responseJSON["title"] as? String else {
                            print("Invalid tag information received from the service")
                            return
                    }
                    
                    self.modelData.response = results as Array
                    self.modelData.title = title
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

