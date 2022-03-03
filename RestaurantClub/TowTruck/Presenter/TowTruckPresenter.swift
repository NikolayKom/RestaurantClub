//
//  TowTruckCallPresenter.swift
//  RestaurantClub
//
//  Created by Николай on 07.02.2022.
//

import Foundation

final class TowTruckPresenter {
    
//MARK: - MVP
    weak var viewController: TowTruckViewController?
    
    init(viewController: TowTruckViewController) {
        self.viewController = viewController
    }
}
