//
//  UITableViewCellHeaderTableViewCell.swift
//  RestoranClub
//
//  Created by Николай on 16.05.2021.
//

import UIKit

protocol DataTransportByButton {
    func didReviewButtonPressed()
    func didMenuButtonPressed()
}

final class TableViewCellHeaderTableViewCell: UITableViewCell {
    
    var delegate: DataTransportByButton?
    
// MARK: - Outlet
    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet private weak var reviewButton: UIButton!
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var typeOfKitchenLabel: UILabel!
    @IBOutlet private weak var restaurantLogoImage: UIImageView!

// MARK: - Action
    @IBAction private func reviewButtonPressed(_ sender: Any) {
        self.delegate?.didReviewButtonPressed()
    }
    
    @IBAction private func menuButtonPressed(_ sender: Any) {
        self.delegate?.didMenuButtonPressed()
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
