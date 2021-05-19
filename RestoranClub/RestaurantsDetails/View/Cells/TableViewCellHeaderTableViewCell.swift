//
//  UITableViewCellHeaderTableViewCell.swift
//  RestoranClub
//
//  Created by Николай on 16.05.2021.
//  Copyright © 2021 Kreative Developer. All rights reserved.
//

import UIKit

class TableViewCellHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var typeOfKitchenLabel: UILabel!
    
    @IBOutlet weak var restaurantLogoImage: UIImageView!
    
    func configure(model: Restorant) {
        
        //aboutRestoranLabel.text = model.aboutRestaurant
        
        restaurantNameLabel.text = model.restaurantName
        typeOfKitchenLabel.text = model.descriptionRestaurant
        if let image = model.image.first {
            let urlString = "http://0b06dfb69e35.ngrok.io/media/\(image)"
            restaurantLogoImage.loadImage(urlString: urlString)
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
