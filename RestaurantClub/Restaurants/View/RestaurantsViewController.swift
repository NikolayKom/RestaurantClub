//
//   Created by Komissarov Nikolay on 09.05.2021.
//   Copyright (c) 2021. All rights reserved.
//

import UIKit

final class RestaurantsViewController: UIViewController, UITableViewDelegate {

//MARK: - MVP
	lazy var presenter = RestaurantsPresenter(viewController: self)
    
//MARK: - Outlet
	@IBOutlet private weak var citySearchBox: UISearchBar!
    @IBOutlet private weak var cardButton: UIButton!
    @IBOutlet private weak var mycollectionView: UICollectionView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var cardView: UICollectionView!
    @IBOutlet private weak var promoTableViewContainer: UITableView!
    
//MARK: - Action
    @IBAction private func sosButtonClicked(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TowTruckViewControllerID") as! TowTruckViewController
        self.present(vc, animated:true, completion: nil)
    }
    
    @IBAction private func cardButtonClicked(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpVCid") as! OrdersViewController // 1
        
        self.addChild(popUpVC) // 2
        popUpVC.view.frame = self.view.frame  // 3
        self.view.addSubview(popUpVC.view) // 4
        
        popUpVC.didMove(toParent: self)
    }
    
//MARK: - Params
    private var restoranSelected = String()
    private var restaurantMenu = String()
    
//MARK: - LifeStyle
	override func viewDidLoad() {
		super.viewDidLoad()
        self.presenter.setup()
        self.swipeDown()
        self.registerCell()
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
    
    private func registerCell() {
        self.promoTableViewContainer.dataSource = self
        self.promoTableViewContainer.delegate = self
        
        let cell = UINib(nibName: "PromoTableViewCell", bundle: nil)
        
        self.promoTableViewContainer.register(cell, forCellReuseIdentifier: "PromoCustomCell")
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
            
        alert.addAction(.init(title: R.string.alerts.ok(),
                              style: .cancel, handler: nil))
        alert.addAction(.init(title: R.string.alerts.update(), style: .default, handler: { [weak self] _ in
               // self?.presenter.obtainRestorans()
            }))

		present(alert, animated: true, completion: nil)
	}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension RestaurantsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	
	func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int)
    -> Int {
        presenter.restaurants.count ?? 0
	}
	
	func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: "StoCollectionViewCell",
			for: indexPath
		) as! StoCollectionViewCell
        //if let restaurant = presenter.restaurants[indexPath.item] {
            if presenter.searching {
                cell.configureSearching(model: presenter.restaurants[indexPath.item])
                self.activityIndicator.stopAnimating()
            } else {
                cell.configure(model: presenter.restaurants[indexPath.item])
                self.activityIndicator.stopAnimating()
            //}
		}
		return cell
	}
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let restoran = presenter.restaurants[indexPath.item]
        self.restoranSelected = "\(restoran.restaurantId ?? 1)"
        
        if let menu = restoran.menu {
            self.restaurantMenu = menu
        }
        
        performSegue(withIdentifier: "showViewController", sender: nil)
    }
    
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        let destination:  RestaurantsDetailViewController = segue.destination as!  RestaurantsDetailViewController
        destination.restoranIndex = self.restoranSelected
        destination.restoranMenu = self.restaurantMenu
    }
}

// MARK: - UISearchBarDelegate
extension RestaurantsViewController: UISearchBarDelegate {
	
	func searchBar(
		_ searchBar: UISearchBar,
		textDidChange searchText: String
	) {
		//presenter.obtainSearch(searchText: searchText)
        self.presenter.searching = true
        self.mycollectionView.reloadData()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		//presenter.obtainRestorans()
        self.presenter.searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        self.mycollectionView.reloadData()
	}
}

//MARK: - UIGestureRecognizerDelegate
extension RestaurantsViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
    -> Bool {
        return true
     }
    
    @objc func hideKeyboardOnSwipeDown() {
        view.endEditing(true)
        self.presenter.searching = false
        self.mycollectionView.reloadData()
     }
}

extension RestaurantsViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromoCustomCell") as? PromoTableViewCell
        else { return UITableViewCell() }
        
        cell.configure()
        cell.delegate = self
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - OpenByCellClicked
extension RestaurantsViewController: OpenByCellClicked {
    
    func didCellClicked(promoSto: Int) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RestaurantsDetailID") as! RestaurantsDetailViewController
        vc.restoranIndex = "\(promoSto)"
        vc.restoranMenu = "any"
        self.present(vc, animated: true)
    }
}
