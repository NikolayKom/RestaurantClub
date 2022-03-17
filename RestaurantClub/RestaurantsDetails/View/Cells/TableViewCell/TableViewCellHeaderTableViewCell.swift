//
//  UITableViewCellHeaderTableViewCell.swift
//  RestoranClub
//
//  Created by Николай on 16.05.2021.
//

import UIKit
import Kingfisher
// TODO: - передалать на enum кнопки
protocol DataTransportByButton {
    func didReviewButtonPressed()
    func didMenuButtonPressed()
    func didRouteButtonPressed()
    func didEntryButtonPressed()
}

final class TableViewCellHeaderTableViewCell: UITableViewCell {
    
    var delegate: DataTransportByButton?
    
// MARK: - Outlet
    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet private weak var reviewButton: UIButton!
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var typeOfKitchenLabel: UILabel!
    @IBOutlet private weak var restaurantLogoImage: UIImageView!
    @IBOutlet private weak var routeButton: UIButton!
    
// MARK: - Action
    @IBAction private func reviewButtonPressed(_ sender: Any) {
        self.delegate?.didReviewButtonPressed()
    }
    
    @IBAction private func menuButtonPressed(_ sender: Any) {
        self.delegate?.didMenuButtonPressed()
    }
    @IBAction private func routeButtonPressed(_ sender: Any) {
        self.delegate?.didRouteButtonPressed()
    }
    
    @IBAction private func entryButtonPressed(_ sender: Any) {
        self.delegate?.didEntryButtonPressed()
    }
    
    func configure(model: FakeRestorant) {
        self.restaurantNameLabel.text = model.restaurantName
        self.typeOfKitchenLabel.text = model.descriptionRestaurant
        if let image = model.profileImage.first {
            //let urlString = baseURL + "/media/\(image)"
            let urlString = URL(string: "\(image)")
            self.restaurantLogoImage.kf.setImage(with: urlString)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
}
