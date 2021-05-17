//
//  UITableViewCellHeaderTableViewCell.swift
//  RestoranClub
//
//  Created by Николай on 16.05.2021.
//  Copyright © 2021 Kreative Developer. All rights reserved.
//

import UIKit

class TableViewCellHeaderTableViewCell: UITableViewCell {
   // @IBOutlet var restoranNameLabel: UILabel!
   // @IBOutlet var typeOfKitchenLabel: UILabel!
    //@IBOutlet weak var aboutRestoranLabel: UILabel!
   // @IBOutlet weak var restoranLogoImage: UIImageView!
    
    @IBOutlet weak var Test: UILabel!
    
    func configure(model: Restorant) {
        //restoranNameLabel.text = model.restaurantName
       // typeOfKitchenLabel.text = model.descriptionRestaurant
        //aboutRestoranLabel.text = model.aboutRestaurant
        Test.text = "ты лох"
        if let image = model.image.first {
            let urlString = "http://2e1af2b5afff.ngrok.io/media/\(image)"
           // restoranLogoImage.loadImage(urlString: urlString)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
