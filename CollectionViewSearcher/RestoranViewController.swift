

import UIKit

class RestoranViewController: UIViewController {
    @IBOutlet var restoranName: UILabel!
    
    var restoranIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
		restoranName.text = "\(restoranIndex)"
	}
}
