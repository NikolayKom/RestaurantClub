

import UIKit

class  RestaurantsDetailViewController: UIViewController {
    
    lazy var detailPresenter = RestaurantsDetailsPresenter(DetailViewController: self)
    
    @IBOutlet var restoranNameLabel: UILabel!
    @IBOutlet weak var typeOfKitchenLabel: UILabel!
    @IBOutlet weak var aboutRestoranLabel: UILabel!
    
    var restoranIndex: String = ""
    var aboutRestoran: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
		restoranNameLabel.text = "\(restoranIndex)"
        aboutRestoranLabel.text = "\(aboutRestoran)"
	}
}
