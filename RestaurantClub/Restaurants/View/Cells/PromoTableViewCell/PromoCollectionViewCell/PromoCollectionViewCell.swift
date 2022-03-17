//
//  PromoCollectionViewCell.swift
//  RestaurantClub
//
//  Created by Николай on 16.03.2022.
//

import UIKit

final class PromoCollectionViewCell: UICollectionViewCell {
    
// MARK: - Outlet
    @IBOutlet private weak var promoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

// MARK: - Configure
    func configure(model: FakePromo) {
        self.promoImage.image = model.promoImage
    }
}
