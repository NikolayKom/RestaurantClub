//
//  CollectionViewCell.swift
//  RestoranClub
//
//  Created by Николай on 21.05.2021.
//

import UIKit
import Cosmos

final class CollectionViewCell: UICollectionViewCell {

// MARK: - Outlet
    @IBOutlet private weak var nameUserLabel: UILabel!
    @IBOutlet private weak var reviewTextLabel: UILabel!
    @IBOutlet private weak var starsView: CosmosView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        contentView.layer.cornerRadius = 15.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 5.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: contentView.layer.cornerRadius
        ).cgPath
        layer.cornerRadius = 15.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: FakeReview) {
        self.nameUserLabel.text = model.userName
        self.reviewTextLabel.text = model.review
        self.setupStars(rating: model.stars)
    }
    
// MARK: - Private methods
    private func setupStars(rating: Int) {
        self.starsView.rating = Double(rating)
    }
}
