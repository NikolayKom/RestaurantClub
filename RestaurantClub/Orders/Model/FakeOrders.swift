//
//  FakeOrders.swift
//  RestaurantClub
//
//  Created by Николай on 11.03.2022.
//

import Foundation

class FakeOrders {
    let nameOfOrder: String
    let status: String
    let statusCode: Bool?
    
    init(nameOfOrder: String,
         status: String,
         statusCode: Bool?
    ) {
        self.nameOfOrder = nameOfOrder
        self.status = status
        self.statusCode = statusCode
    }
}

extension FakeOrders {
    static let allFakeOrders = [
        FakeOrders(nameOfOrder: "Заказ в сервисе У Ашота",
                   status: "Выполнен",
                   statusCode: true),
        FakeOrders(nameOfOrder: "СТО столичное",
                   status: "Отменен",
                   statusCode: false),
        FakeOrders(nameOfOrder: "Best service",
                   status: "В обработке",
                   statusCode: nil)
    ]
}
