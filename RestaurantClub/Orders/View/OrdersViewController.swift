//
//  PopUpViewController.swift
//  RestaurantClub
//
//  Created by Николай on 11.03.2022.
//

import Foundation
import UIKit

class OrdersViewController: UIViewController, UITableViewDelegate {
    
    lazy var ordersPresenter = OrdersPresenter(viewController: self)
    
// MARK: - Outlet
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var orderTableView: UITableView!
    
// MARK: - Action
    @IBAction private func closeButtonPressed(_ sender: Any) {
        self.moveOut()
    }

// MARK: - Perm
    private let reuseIdentifier = "OrderCell"
    
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        self.registerCell()
        self.moveIn()
    }
    
// MARK: - Private methods
    private func moveIn() {
        self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    private func moveOut() {
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
    
    private func registerCell() {
        self.orderTableView.dataSource = self
        self.orderTableView.delegate = self
        
        let entryCell = UINib(nibName: self.reuseIdentifier, bundle: nil)
        
        self.orderTableView.register(entryCell,
                                       forCellReuseIdentifier: self.reuseIdentifier)
    }
}

extension OrdersViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        self.ordersPresenter.orders.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier,  for: indexPath) as? OrderCell
        else { return UITableViewCell() }
        
        let order = self.ordersPresenter.orders[indexPath.item]
        cell.configure(model: order)
        return cell
    }
}
