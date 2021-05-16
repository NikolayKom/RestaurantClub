

import UIKit

class  RestaurantsDetailViewController: UIViewController {
    
    lazy var detailPresenter = RestaurantsDetailsPresenter(DetailViewController: self)
    
    @IBOutlet var restoranNameLabel: UILabel!
    @IBOutlet var typeOfKitchenLabel: UILabel!
    @IBOutlet weak var aboutRestoranLabel: UILabel!
    @IBOutlet weak var restoranLogoImage: UIImageView!
    
    var restoranIndex: String = ""
    var aboutRestoran: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // detailPresenter.sendReview() - отправка отзыва на ресторан
	}
    
    override func viewDidAppear(_ animated: Bool) {
        detailPresenter.obtainRestoranById(id: restoranIndex)
    }
    
    func showRestaurants() {
        
        if let restaurant = detailPresenter.restaurants {
            configure(model: restaurant)
        }
    }
    
    func showError(title: String, message: String, restoranNumber: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
            )
            
            alert.addAction(.init(title: "Ок", style: .cancel, handler: nil))
            alert.addAction(.init(title: "Обновить", style: .default, handler: { [weak self] _ in
                self?.detailPresenter.obtainRestoranById(id: restoranNumber)
            }))

        present(alert, animated: true, completion: nil)
    }
            
    
    func configure(model: Restorant) {
        restoranNameLabel.text = model.restaurantName
        typeOfKitchenLabel.text = model.descriptionRestaurant
        aboutRestoranLabel.text = model.aboutRestaurant
        
        if let image = model.image.first {
            let urlString = "http://2e1af2b5afff.ngrok.io/media/\(image)"
            restoranLogoImage.loadImage(urlString: urlString)
        }
    }
}
