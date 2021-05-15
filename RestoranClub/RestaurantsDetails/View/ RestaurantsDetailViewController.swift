

import UIKit

class  RestaurantsDetailViewController: UIViewController {
    
    lazy var detailPresenter = RestaurantsDetailsPresenter(DetailViewController: self)
    
    @IBOutlet var restoranNameLabel: UILabel!
    @IBOutlet weak var typeOfKitchenLabel: UILabel!
    @IBOutlet weak var aboutRestoranLabel: UILabel!
    @IBOutlet weak var restoranLogoImage: UIImageView!
    
    var restoranIndex: String = ""
    var aboutRestoran: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPresenter.obtainRestoranById(id: restoranIndex)
        print(restoranIndex)
        guard let url = URL(string: "http://f35e82e968cf.ngrok.io/create_review") else {
            return
        }
        let params = ["rest_id": 10,
                      "review": "Кормят",
                      "user_name": "К",
                      "stars": 2.2
        ] as [String : Any]
        
       ApiService.callPost(url: url, params: params, finish: detailPresenter.finishPost)
        
	}
    
    func showRestaurants() {
        guard let restaurant = detailPresenter.restaurants else { return print(self.detailPresenter.restaurants) }
        
        configure(model: restaurant)
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
        
        if let image = model.image.first {
            let urlString = "http://f35e82e968cf.ngrok.io/media/\(image)"
            restoranLogoImage.loadImage(urlString: urlString)
        }
    }
}
