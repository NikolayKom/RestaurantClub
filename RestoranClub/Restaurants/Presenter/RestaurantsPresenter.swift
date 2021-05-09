//
//   Created by Statnikov Eugene on 09.05.2021.
//   Copyright (c) 2021 SEA. All rights reserved.
//

import Foundation

class RestaurantsPresenter {
	
	weak var viewController: RestaurantsViewController?
	
	var restaurants: [Restorant]?
	
	init(viewController: RestaurantsViewController) {
		self.viewController = viewController
	}
    
    func setup() {
        viewController?.activityIndicator.hidesWhenStopped = true
        viewController?.activityIndicator.startAnimating()
    }
    
	func obtainRestorans() {
		guard Reachability.isConnectedToNetwork() else {
			viewController?.showError(title: "Ошибка", message: "Нет интернета")
			return
		}
		
		guard let url = URL(string: "http://b0bafa18ee84.ngrok.io/main_map_restaurants_api") else {
			return
		}
		
		URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
			guard let self = self else { return }
			
			if error == nil, let parsData = data {
				let restoransResponse = try? JSONDecoder().decode(RestorantsResponse.self, from: parsData)
				self.restaurants = restoransResponse?.restorants
				DispatchQueue.main.async {
					self.viewController?.showRestaurants()
				}
			} else {
				self.viewController?.showError(title: "Ошибка", message: "Что-то пошло не так!")
			}
			
		}.resume()
		
	}
	
	func obtainSearch(searchText: String) {
		guard Reachability.isConnectedToNetwork() else {
			viewController?.showError(title: "Ошибка", message: "Нет интернета")
			return
		}
		
		guard var components = URLComponents(string: "http://b0bafa18ee84.ngrok.io/search_results_view_api") else {
			return
		}
		
		components.queryItems = [
			URLQueryItem(name: "search", value: searchText)
		]
		
		guard let url = components.url else { return }
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
			guard let self = self else { return }
			
			if error == nil, let parsData = data {
				let restoransResponse = try? JSONDecoder().decode(
					RestorantsResponse.self,
					from: parsData
				)
				
				self.restaurants = restoransResponse?.restorants
				DispatchQueue.main.async {
					self.viewController?.showRestaurants()
				}
				
			} else {
				self.viewController?.showError(title: "Ошибка", message: "Что-то пошло не так!")
			}
			
		}.resume()
	}
}
