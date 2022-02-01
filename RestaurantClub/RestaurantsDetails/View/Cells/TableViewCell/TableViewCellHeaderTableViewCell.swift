//
//  UITableViewCellHeaderTableViewCell.swift
//  RestoranClub
//
//  Created by Николай on 16.05.2021.
//

import UIKit

protocol DataTransportByButton {
    func didButtonPressed()
}

final class TableViewCellHeaderTableViewCell: UITableViewCell {
    
    var delegate: DataTransportByButton?
    
// MARK: - Outlet
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var typeOfKitchenLabel: UILabel!
    @IBOutlet weak var restaurantLogoImage: UIImageView!
    
    @IBAction func actionButton(_ sender: Any) {
        delegate?.didButtonPressed()
    }
    
    func configure(model: FakeRestorant) {
        restaurantNameLabel.text = model.restaurantName
        typeOfKitchenLabel.text = model.descriptionRestaurant
        if let image = model.image.first {
            let urlString = baseURL + "/media/\(image)"
            restaurantLogoImage.loadImage(urlString: urlString)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
}
