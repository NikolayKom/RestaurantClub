//
//  FakeService.swift
//  RestaurantClub
//
//  Created by Николай on 09.03.2022.
//

import Foundation

class FakeService {
    let id: Int
    let serviceCost: Int
    let serviceName: String
    var itemInCard: Bool = false
    
    init(id: Int,
         serviceName: String,
         serviceCost: Int,
         itemInCard: Bool = false
    ){
        self.id = id
        self.serviceName = serviceName
        self.serviceCost = serviceCost
        self.itemInCard = itemInCard
    }
}

extension FakeService {
    static let allFakeService = [
        FakeService(id: 0,
                    serviceName: "Замена переднего поршня",
                    serviceCost: 5500),
        FakeService(id: 1,
                    serviceName: "Замена заднего поршня",
                    serviceCost: 5500),
        FakeService(id: 2,
                    serviceName: "Замена шаровой оси",
                    serviceCost: 12000),
        FakeService(id: 3,
                    serviceName: "Замена переднего рычага",
                    serviceCost: 2700)
        ]
}
