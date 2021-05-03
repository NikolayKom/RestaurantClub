import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var citySearchBox: UISearchBar!
    @IBOutlet weak var mycollectionView: UICollectionView!
    
    var indexSelected = 0
    
    let reuseIdentifier = "cell"
    var restoran = [
		"La Defanse",
		"Le Maison",
		"Gewara",
		"Wok and Wall",
		"Grill",
		"Megas",
		"Yarche",
		"Pomoyka",
		"Green",
        "Poke",
        "Juniglo",
        "Hilo"
	]
    
	
    var searchedCity = [String]()
    var searching = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		citySearchBox.delegate = self
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
                swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
                self.mycollectionView.addGestureRecognizer(swipeDown)
	}
	
    func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return searching ? searchedCity.count : restoran.count
    }
    
    func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: reuseIdentifier,
			for: indexPath as IndexPath
		) as! MyCollectionViewCell
		
        if searching {
            cell.myLabel.text = searchedCity[indexPath.item]
        } else {
            cell.myLabel.text = restoran[indexPath.item]
        }

        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.white.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.layer.cornerRadius = 10.0
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
        indexSelected = indexPath.item + 1
		performSegue(withIdentifier: "showViewController", sender: nil)
    }
	
	// MARK: - UISearchBarDelegate
    
    func searchBar(
		_ searchBar: UISearchBar,
		textDidChange searchText: String
	) {
        searchedCity = restoran.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        mycollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        mycollectionView.reloadData()
    }
    
    override func prepare(
		for segue: UIStoryboardSegue,
		sender: Any?
	) {
        let destination: RestoranViewController = segue.destination as! RestoranViewController
        destination.restoranIndex = indexSelected
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    @objc func hideKeyboardOnSwipeDown() {
            view.endEditing(true)
        }
}

