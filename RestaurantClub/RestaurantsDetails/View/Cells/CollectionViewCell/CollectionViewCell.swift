//
//  CollectionViewCell.swift
//  RestoranClub
//
//  Created by Николай on 21.05.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    
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
        // Initialization code
    
    }
    
    func configure(model: Review) {
        
        nameUserLabel.text = model.userName
        reviewTextLabel.text = model.review
        stars(rating: model.stars)

    }
    
    func stars(rating: Int) {
        switch rating {
        case 0:
            print("Переменная равна 0")
            ratingImage.image = #imageLiteral(resourceName: "Star_rating_0_of_5")
        case 1:
            ratingImage.image = #imageLiteral(resourceName: "Star_rating_1_of_5")
        case 2:
            ratingImage.image = #imageLiteral(resourceName: "Star_rating_2_of_5")
        case 3:
            ratingImage.image = #imageLiteral(resourceName: "Star_rating_3_of_5")
        case 4:
            ratingImage.image = #imageLiteral(resourceName: "Star_rating_4_of_5")
        case 5:
            ratingImage.image = #imageLiteral(resourceName: "Star_rating_5_of_5")
        default:
            ratingImage.image = #imageLiteral(resourceName: "Star_rating_0_of_5")
    }
}
}
