

import UIKit

class RestaurantsDetailViewController: UITableViewController, kallProtocol {
    
    func didButtonPressed() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyBoard.instantiateViewController(withIdentifier: "ViewControllerID") as!  RestaurantsReviewViewController
               self.present(vc,animated:true,completion: nil)
        vc.numberOfRestoran = restoranIndex
    }
    
    
    @IBOutlet weak var detailActivityIndicator: UIActivityIndicatorView!
    
    lazy var detailPresenter = RestaurantsDetailsPresenter(DetailViewController: self)
	
	var restoranIndex: String = ""
	var aboutRestoran: String = ""
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.registerCell()
		detailPresenter.setup()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		detailPresenter.obtainRestoranById(id: restoranIndex)
	}
	
	func showRestaurants() {
		tableView.reloadData()
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
			
			if let restaurant = detailPresenter.restaurants {
				cell.configure(model: restaurant)
			}
            cell.delegate = self
			return cell
		case 1:
			guard let cellMain = tableView.dequeueReusableCell(withIdentifier: "CustomCellMain") as? TableViewMain
			else { return UITableViewCell() }
			
			if let restaurant = detailPresenter.restaurants {
				cellMain.configure(model: restaurant)
			}
			
			return cellMain
		case 2:
			guard let cellReview = tableView.dequeueReusableCell(withIdentifier: "CustomCellReview") as? TableViewCellReview
			else { return UITableViewCell() }
			
			if let restaurant = detailPresenter.restaurants {
				cellReview.configure(model: restaurant)
                detailActivityIndicator.stopAnimating()
                
                if let review = detailPresenter.restaurants?.reviews {
                cellReview.restaurantsReview = review
                
                }
                
            }
            
			return cellReview
		default:
			break
		}
		return UITableViewCell()
	}
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?
    ) {
        let destination:  TableViewCellReview = segue.destination as!  TableViewCellReview
        destination.restaurantsReview = detailPresenter.restaurants?.reviews
    }
	
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

}

