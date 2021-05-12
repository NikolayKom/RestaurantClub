//
//   Created by Statnikov Eugene on 09.05.2021.
//   Copyright (c) 2021 SEA. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController {
	
	lazy var presenter = RestaurantsPresenter(viewController: self)
	
	@IBOutlet weak var citySearchBox: UISearchBar!
	@IBOutlet weak var mycollectionView: UICollectionView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var restoranSelected = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.obtainRestorans()
        presenter.setup()
        swipeDown()
        
        
	}
    
    func swipeDown() {
        let swipeDown =  UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
        swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
        self.mycollectionView.addGestureRecognizer(swipeDown)
    }
	
	func showRestaurants() {
		mycollectionView.reloadData()
	}
	
	func showError(title: String, message: String) {
		let alert = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert
		)
		present(alert, animated: true, completion: nil)
	}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension RestaurantsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		presenter.restaurants?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: "MyCollectionViewCell",
			for: indexPath
		) as! MyCollectionViewCell
		
        if let restaurant = presenter.restaurants?[indexPath.item] {
            if presenter.searching {
                cell.configureSearching(model: restaurant)
                activityIndicator.stopAnimating()
                
            } else {
                cell.configure(model: restaurant)
                activityIndicator.stopAnimating()
            }
                
			
		}
		
		return cell
	}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath
    ) {
        let restoran = presenter.restaurants?[indexPath.item]
        restoranSelected = restoran?.restaurantName ?? "0"
        
        
        performSegue(withIdentifier: "showViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?
    ) {
        let destination:  RestaurantsDetailViewController = segue.destination as!  RestaurantsDetailViewController
        destination.restoranIndex = restoranSelected
    }

}

// MARK: - UISearchBarDelegate

extension RestaurantsViewController: UISearchBarDelegate {
	
	func searchBar(
		_ searchBar: UISearchBar,
		textDidChange searchText: String
	) {
		presenter.obtainSearch(searchText: searchText)
        presenter.searching = true
        mycollectionView.reloadData()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		presenter.obtainRestorans()
        presenter.searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        mycollectionView.reloadData()
	}
}

//MARK: - UIGestureRecognizerDelegate

extension RestaurantsViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
     }
    
    @objc func hideKeyboardOnSwipeDown() {
        view.endEditing(true)
        presenter.searching = false
        mycollectionView.reloadData()
     }

}

    

