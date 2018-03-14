//
//  CountryTableViewCell.swift
//  TestApp
//
//  Created by Nancy Himanshu Sharma on 14/3/18.
//  Copyright © 2018 Nancy Himanshu Sharma. All rights reserved.
//

import UIKit
import AlamofireImage

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageViewCountry: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellValues(title: String?, description: String?, imageUrl: String?) {

        labelTitle.text = title
        labelDescription.text = description
        
        Alamofire.request(imageUrl).responseImage { response in
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.imageViewCountry.image = image
            }
        }
    }
    
}
