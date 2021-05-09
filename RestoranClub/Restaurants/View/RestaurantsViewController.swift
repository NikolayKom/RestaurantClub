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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.obtainRestorans()
        
        presenter.setup()
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
			cell.configure(model: restaurant)
            activityIndicator.stopAnimating()
		}
		
		return cell
	}	
}

// MARK: - UISearchBarDelegate

extension RestaurantsViewController: UISearchBarDelegate {
	
	func searchBar(
		_ searchBar: UISearchBar,
		textDidChange searchText: String
	) {
		presenter.obtainSearch(searchText: searchText)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		presenter.obtainRestorans()
	}
}
