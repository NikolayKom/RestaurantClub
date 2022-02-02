//
//   Created by Nikolay on 09.05.2021.
//   Copyright (c) 2021. All rights reserved.
//

import Foundation

final class RestaurantsPresenter {
	
	weak var viewController: RestaurantsViewController?
	
    var restaurants = FakeRestorant.allFakeRestorant
    //var restaurants: [Restorant]?
    var searching = false
    
	init(viewController: RestaurantsViewController) {
		self.viewController = viewController
	}
    
//MARK: - Public methods
    func setup() {
        self.viewController?.activityIndicator.hidesWhenStopped = true
        self.viewController?.activityIndicator.startAnimating()
    }
    
    func onSosButtonClicked() {
        
    }

//	func obtainRestorans() {
//		guard Reachability.isConnectedToNetwork() else {
//            viewController?.showError(title: "Ошибка", message: "Нет интернета")
//			return
//		}
//
//		guard let url = URL(string: baseURL + "/main_map_restaurants_api") else {
//			return
//		}
//
//		URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//			guard let self = self else { return }
//
//			if error == nil, let parsData = data {
//				let restoransResponse = try? JSONDecoder().decode(RestorantsResponse.self, from: parsData)
//                self.restaurants = restoransResponse?.restorants
//				DispatchQueue.main.async {
//					self.viewController?.showRestaurants()
//				}
//			} else {
//				self.viewController?.showError(title: "Ошибка", message: "Что-то пошло не так!")
//			}
//		}.resume()
//	}
	
//	func obtainSearch(searchText: String) {
//		guard Reachability.isConnectedToNetwork() else {
//			viewController?.showError(title: "Ошибка", message: "Нет интернета")
//			return
//		}
//
//		guard var components = URLComponents(string: "http://3598a32ff8cc.ngrok.io/search_results_view_api") else {
//			return
//		}
//		
//		components.queryItems = [
//			URLQueryItem(name: "search", value: searchText)
//		]
//		
//		guard let url = components.url else { return }
//		let request = URLRequest(url: url)
//		
//		URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
//			guard let self = self else { return }
//			
//			if error == nil, let parsData = data {
//				let restoransResponse = try? JSONDecoder().decode(
//					RestorantsResponse.self,
//					from: parsData
//				)
//				
//				self.restaurants = restoransResponse?.restorants
//				DispatchQueue.main.async {
//					self.viewController?.showRestaurants()
//				}
//				
//			} else {
//				self.viewController?.showError(title: "Ошибка", message: "Что-то пошло не так!")
//			}
//			
//		}.resume()
//	}
    
    
}
