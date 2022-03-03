//
//   Created by Komissarov Nikolay on 09.05.2021.
//   Copyright (c) 2021. All rights reserved.
//

import UIKit
import Cosmos

final class MyCollectionViewCell: UICollectionViewCell {
    
	@IBOutlet private weak var nameOfRestaurant: UILabel!
	@IBOutlet private weak var avarageCheckLabel: UILabel!
	@IBOutlet private weak var adressOrDishLabel: UILabel!
	@IBOutlet private weak var logoImage: UIImageView!
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
			let urlString = baseURL + "/media/\(image)"
            self.logoImage.loadImage(urlString: urlString)
		}
	}
    
    func configureSearching(model: FakeRestorant) {
        self.nameOfRestaurant.text = model.restaurantName
        self.adressOrDishLabel.text = model.dish
        
        self.setupStars(rating: model.rating)
        self.prepareAvarageCheck(averageCheckRestaurant: model.averageCheckRestaurant)
        
        if let image = model.image.first {
            let urlString = baseURL + "/media/\(image)"
            self.logoImage.loadImage(urlString: urlString)
        }
    }
    
//MARK: - Private method
    private func setupStars(rating: Double) {
        self.starsView.rating = rating
    }
    
   private func prepareAvarageCheck(averageCheckRestaurant: Int) {
        if averageCheckRestaurant < 1000 {
            self.avarageCheckLabel.text = R.string.restaurants.avarageCheckLow()
        } else if averageCheckRestaurant < 1700 {
            self.avarageCheckLabel?.text = R.string.restaurants.avarageCheckMedium()
        } else {
            self.avarageCheckLabel?.text = R.string.restaurants.avarageCheckHigh()
        }
    }
}
