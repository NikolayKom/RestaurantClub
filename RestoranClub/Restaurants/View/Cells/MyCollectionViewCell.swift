

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var myLabel: UILabel!
	@IBOutlet weak var avarageCheckLabel: UILabel!
	@IBOutlet weak var adressLabel: UILabel!
	@IBOutlet weak var logo: UIImageView!
	@IBOutlet weak var starsImage: UIImageView!
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	
		contentView.layer.cornerRadius = 2.0
		contentView.layer.borderWidth = 1.0
		contentView.layer.borderColor = UIColor.clear.cgColor
		contentView.layer.masksToBounds = true
		layer.shadowColor = UIColor.white.cgColor
		layer.shadowOffset = CGSize(width: 0, height: 2.0)
		layer.shadowRadius = 2.0
		layer.shadowOpacity = 1.0
		layer.masksToBounds = false
		layer.shadowPath = UIBezierPath(
			roundedRect: bounds,
			cornerRadius: contentView.layer.cornerRadius
		).cgPath
		layer.cornerRadius = 10.0

	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		logo.image = nil
	}
	
	func configure(model: Restorant) {
		myLabel.text = model.restaurantName
		adressLabel.text = model.location
        
		
        if let image = model.image.first {
			let urlString = "http://b0bafa18ee84.ngrok.io/media/\(image)"
			logo.loadImage(urlString: urlString)
		}
	}
}
