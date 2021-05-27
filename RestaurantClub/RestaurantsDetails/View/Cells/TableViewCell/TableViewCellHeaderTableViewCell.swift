//
//  UITableViewCellHeaderTableViewCell.swift
//  RestoranClub
//
//  Created by Николай on 16.05.2021.
//

import UIKit

protocol kallProtocol {
    func didButtonPressed()
}

class TableViewCellHeaderTableViewCell: UITableViewCell {
    
    var delegate: kallProtocol?
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var typeOfKitchenLabel: UILabel!
    @IBOutlet weak var restaurantLogoImage: UIImageView!
    
    @IBAction func actionButton(_ sender: Any) {
        delegate?.didButtonPressed()
    }
    
  

    func configure(model: Restorant) {
        //aboutRestoranLabel.text = model.aboutRestaurant
        
        restaurantNameLabel.text = model.restaurantName
        typeOfKitchenLabel.text = model.descriptionRestaurant
        if let image = model.image.first {
            let urlString = baseURL + "/media/\(image)"
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
