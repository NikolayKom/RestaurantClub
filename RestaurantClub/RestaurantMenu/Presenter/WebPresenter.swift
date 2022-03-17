//
//  WebPresenter.swift
//  RestaurantClub
//
//  Created by Николай on 02.02.2022.
//

import Foundation

final class WebPresenter {
    
//MARK: - MVP
    weak var viewController: WebViewCotroller?
    
    init(viewController: WebViewCotroller) {
        self.viewController = viewController
    }
    
    func createRequest(restaurantMenu: String) -> URLRequest {
        var serviceURL: URL!
        serviceURL = URL(string: "\(restaurantMenu)")
        let serviceRequest = URLRequest(url: serviceURL!)
        return serviceRequest
    }
}
