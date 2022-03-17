//
//  OrdersPresenter.swift
//  RestaurantClub
//
//  Created by Николай on 11.03.2022.
//

import Foundation

class OrdersPresenter {
    
    weak var ordersViewController: OrdersViewController?
    
    var orders = FakeOrders.allFakeOrders
    
    init(viewController: OrdersViewController) {
        self.ordersViewController = viewController
    }
}
