//
//   Created by Komissarov Nikolay on 09.05.2021.
//   Copyright (c) 2021. All rights reserved.
//

import UIKit

final class RestaurantsViewController: UIViewController {
	
	lazy var presenter = RestaurantsPresenter(viewController: self)
	
	@IBOutlet private weak var citySearchBox: UISearchBar!
	@IBOutlet private weak var mycollectionView: UICollectionView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
   private var restoranSelected = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
        presenter.setup()
        swipeDown()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //presenter.obtainRestorans()
        self.showRestaurants()
    }
    
//MARK: - Private methods
    private func swipeDown() {
        let swipeDown =  UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
        swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
        self.mycollectionView.addGestureRecognizer(swipeDown)
    }
    
//MARK: - Public methods
    
    func showRestaurants() {
		mycollectionView.reloadData()
	}
	
    func showError(title: String, message: String) {
		let alert = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert
            )
            
            alert.addAction(.init(title: "Ок", style: .cancel, handler: nil))
            alert.addAction(.init(title: "Обновить", style: .default, handler: { [weak self] _ in
               // self?.presenter.obtainRestorans()
            }))

		present(alert, animated: true, completion: nil)
	}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension RestaurantsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.restaurants.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: "MyCollectionViewCell",
			for: indexPath
		) as! MyCollectionViewCell
		
        //if let restaurant = presenter.restaurants[indexPath.item] {
            if presenter.searching {
                cell.configureSearching(model: presenter.restaurants[indexPath.item])
                activityIndicator.stopAnimating()
                
            } else {
                cell.configure(model: presenter.restaurants[indexPath.item])
                activityIndicator.stopAnimating()
            //}
                
			
		}
		
		return cell
	}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath
    ) {
        let restoran = presenter.restaurants[indexPath.item]
        restoranSelected = "\(restoran.restaurantId ?? 1)"
        
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
		//presenter.obtainSearch(searchText: searchText)
        presenter.searching = true
        mycollectionView.reloadData()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		//presenter.obtainRestorans()
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

    

