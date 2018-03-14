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
    
    var model = CountryTableModel()
    var modelData = CountryData()
    
    var rows: Int {
        return modelData.response.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchServerData()
        setUpCellIdentifiers()
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
                        let firstObject = json.first else {
                            print("Invalid tag information received from the service")
                            return
                    }

                    print(results)
                    print(firstObject)
                    self.modelData.response = results as Array
                    print(self.modelData.response)
                    print(self.modelData.response.count)
                    
                    DispatchQueue.main.async {

                        self.tableView.reloadData()
                    }

                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
//    func didReceiveResponse(_ response: [String: Any]) {
//
//        let dict = response.flatMap({ (dict) -> CountryData? in
//            guard let r = dict["title"] as? String,
//                let g = dict["description"] as? String,
//                let b = dict["imageHref"] as? String else {
//                    return nil
//            }
//
//            return CountryData(red: Int(r),
//                              green: Int(g),
//                              blue: Int(b),
//                              colorName: closestPaletteColor)
//        })
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

