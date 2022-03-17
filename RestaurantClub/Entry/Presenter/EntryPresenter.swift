//
//  EntryPresenter.swift
//  RestaurantClub
//
//  Created by Николай on 05.03.2022.
//

import Foundation

final class EntryPresenter {
    
//MARK: - MVP
    weak var viewController: EntryViewController?
    
    var services = FakeService.allFakeService
    
    init(viewController: EntryViewController) {
        self.viewController = viewController
    }
    
// MARK: - Public methods
    func addService(id: Int) {
        self.sortServices(addItem: true, id: id)
    }
    
    func removeService(id: Int) {
        self.sortServices(addItem: false, id: id)
    }
    
    func removeAllServices() {
        self.services.forEach { service in
            service.itemInCard = false
        }
    }
    
// MARK: - Private methods
    private func sortServices(addItem: Bool, id: Int) {
        self.services.forEach { service in
            service.id == id ? service.itemInCard = addItem : nil
        }
        self.services.sort { $0.itemInCard && !$1.itemInCard }
    }
}
