

import UIKit

class RestoranViewController: UIViewController {
    @IBOutlet var restoranNameLabel: UILabel!
    
    @IBOutlet weak var typeOfKitchenLabel: UILabel!
    
    @IBOutlet weak var discriptionRestoranLabel: UILabel!
    
    var restoranIndex: String = ""
    var discriptionRestoran: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
		restoranNameLabel.text = "\(restoranIndex)"
        discriptionRestoranLabel.text = "\(discriptionRestoran)"
	}
}
