//
//   Created by Komissarov Nikolay on 09.05.2021.
//   Copyright (c) 2021. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

final class StoCollectionViewCell: UICollectionViewCell {
    
	@IBOutlet private weak var nameOfRestaurant: UILabel!
	@IBOutlet private weak var avarageCheckLabel: UILabel!
	@IBOutlet private weak var adressOrDishLabel: UILabel!
	@IBOutlet private weak var logoImage: UIImageView!
    @IBOutlet private weak var starsView: CosmosView!
    
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	
		contentView.layer.cornerRadius = 15.0
		contentView.layer.borderWidth = 1.0
		contentView.layer.borderColor = R.color.darkGray()?.cgColor
		contentView.layer.masksToBounds = true
		layer.shadowColor = R.color.darkGray()?.cgColor
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
	
	override func prepareForReuse() {
		super.prepareForReuse()
        
        self.logoImage.image = nil
	}
    
//MARK: - Public method
	func configure(model: FakeRestorant) {
        self.nameOfRestaurant.text = model.restaurantName
        self.adressOrDishLabel.text = model.location
        
        self.setupStars(rating: model.rating)
        self.prepareAvarageCheck(averageCheckRestaurant: model.averageCheckRestaurant)
        
        if let image = model.image.first {
			//let urlString = baseURL + "/media/\(image)"
            let urlString = URL(string: "\(image)")
            self.logoImage.kf.setImage(with: urlString)
		}
	}
    
    func configureSearching(model: FakeRestorant) {
        self.nameOfRestaurant.text = model.restaurantName
        self.adressOrDishLabel.text = model.dish
        
        self.setupStars(rating: model.rating)
        self.prepareAvarageCheck(averageCheckRestaurant: model.averageCheckRestaurant)
        
        if let image = model.image.first {
            let urlString = baseURL + "/media/\(image)"
            let url = URL(string: "\(urlString)")
            self.logoImage.kf.setImage(with: url)
        }
    }
    
//MARK: - Private method
    private func setupStars(rating: Double) {
        self.starsView.rating = rating
    }
    
    private func prepareAvarageCheck(averageCheckRestaurant: Int) {
        if averageCheckRestaurant < .avarageCheckLow {
            self.avarageCheckLabel.text = R.string.restaurants.avarageCheckLow()
        } else if averageCheckRestaurant < .avarageCheckMedium {
            self.avarageCheckLabel?.text = R.string.restaurants.avarageCheckMedium()
        } else {
            self.avarageCheckLabel?.text = R.string.restaurants.avarageCheckHigh()
        }
    }
}

// MARK: - Int
private extension Int {
    static let avarageCheckLow = 1000
    static let avarageCheckMedium = 1700
}
