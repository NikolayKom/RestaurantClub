//
//  RestaurantsDetailsPresenter.swift
//  RestoranClub
//
//  Created by Николай on 12.05.2021.
//  Copyright © 2021 Kreative Developer. All rights reserved.
//

import Foundation

class RestaurantsDetailsPresenter {
    
    weak var DetailViewController: RestaurantsDetailViewController?
    
    init(DetailViewController:  RestaurantsDetailViewController) {
        self.DetailViewController = DetailViewController
    }
    
    
    
}



