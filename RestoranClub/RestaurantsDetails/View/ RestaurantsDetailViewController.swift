

import UIKit

class  RestaurantsDetailViewController: UITableViewController {
    
    lazy var detailPresenter = RestaurantsDetailsPresenter(DetailViewController: self)
    
    var restoranIndex: String = ""
    var aboutRestoran: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
       // detailPresenter.sendReview() - отправка отзыва на ресторан
	}
    
    override func viewDidAppear(_ animated: Bool) {
        detailPresenter.obtainRestoranById(id: restoranIndex)
        print(detailPresenter.restaurants?.restaurantName)
        print(restoranIndex)
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
        let cell = UINib(nibName: "UITableViewCellHeaderTableViewCell", bundle: nil)
        
        self.tableView.register(cell, forCellReuseIdentifier: "CustomCell")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? UITableViewCellHeaderTableViewCell else {
            return UITableViewCell()
        }
        print(detailPresenter.restaurants?.restaurantName)
    if let restaurant = detailPresenter.restaurants {
        cell.configure(model: restaurant)
        print("zzz")
    
    }
        return cell
    }
}
