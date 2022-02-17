import UIKit

final class RestaurantsDetailViewController: UITableViewController, DataTransportByButton {
    
//MARK: - Outlet
    @IBOutlet weak var detailActivityIndicator: UIActivityIndicatorView!

//MARK: - MVP
    lazy var detailPresenter = RestaurantsDetailsPresenter(DetailViewController: self)
    
//MARK: - Perm
    private var aboutRestoran = String()
    
    internal var restoranIndex = String()
    internal var restoranMenu = String()
	
//MARK: - Lifestyle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.registerCell()
		detailPresenter.setup()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
        self.showRestaurants()
		//detailPresenter.obtainRestoranById(id: restoranIndex)
	}
    
// MARK: - Public methods
	func showRestaurants() {
		tableView.reloadData()
        //detailPresenter.reviews = detailPresenter.restaurants.reviews
        self.detailPresenter.reviews = detailPresenter.reviews
	}
    
	func showError(title: String, message: String, restoranNumber: String) {
		let alert = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert
		)
		
		alert.addAction(.init(title: "Ок", style: .cancel, handler: nil))
		alert.addAction(.init(title: "Обновить", style: .default, handler: { [weak self] _ in
			//self?.detailPresenter.obtainRestoranById(id: restoranNumber)
		}))
		
		present(alert, animated: true, completion: nil)
	}
    
    func didReviewButtonPressed() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyBoard.instantiateViewController(withIdentifier: "ViewControllerID") as! RestaurantsReviewViewController
               self.present(vc, animated:true, completion: nil)
        vc.numberOfRestoran = restoranIndex
    }
    
    func didMenuButtonPressed() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyBoard.instantiateViewController(withIdentifier: "WebViewControllerID") as! WebViewCotroller
               self.present(vc, animated:true, completion: nil)
        vc.restaurantMenu = self.restoranMenu
    }
    
    func didRouteButtonPressed() {
        //TODO: забрать коорды и название с api
        OpenMapDirections.present(in: self,
                                  sourceView: self.view,
                                  serviceName: "Тестовый сервис",
                                  latitude: 55.058671,
                                  langitude: 82.939942)
    }
    
//MARK: - Private method
	private func registerCell() {
		let cell = UINib(nibName: "TableViewCellHeaderTableViewCell", bundle: nil)
		let cellMain = UINib(nibName: "TableViewMain", bundle: nil)
		let cellReview = UINib(nibName: "TableViewCellReview", bundle: nil)
		
		self.tableView.register(cell, forCellReuseIdentifier: "CustomCell")
		self.tableView.register(cellMain, forCellReuseIdentifier: "CustomCellMain")
		self.tableView.register(cellReview, forCellReuseIdentifier: "CustomCellReview")
	}

// MARK: - TableView
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		return 3
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {

		switch indexPath.row {
		case 0:
			guard var cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? TableViewCellHeaderTableViewCell
			else { return UITableViewCell() }
			
			//if let restaurant = detailPresenter.restaurants {
            // убрать first!
            cell.configure(model: detailPresenter.restaurants.first!)
			//}
            cell.delegate = self
			return cell
		case 1:
			guard let cellMain = tableView.dequeueReusableCell(withIdentifier: "CustomCellMain") as? TableViewMain
			else { return UITableViewCell() }
			
			//if let restaurant = detailPresenter.restaurants {
            // убрать first!
            cellMain.configure(model: detailPresenter.restaurants.first!)
			//}
			return cellMain
		case 2:
			guard let cellReview = tableView.dequeueReusableCell(withIdentifier: "CustomCellReview") as? TableViewCellReview
			else { return UITableViewCell() }
            
            //if let restaurant = detailPresenter.reviews {
                detailActivityIndicator.stopAnimating()
                cellReview.restaurantsReview = detailPresenter.reviews
                cellReview.configure()
                
           // }
			return cellReview
		default:
			break
		}
		return UITableViewCell()
	}
    
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

