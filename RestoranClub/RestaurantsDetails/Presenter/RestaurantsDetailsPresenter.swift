//
//  RestaurantsDetailsPresenter.swift
//  RestoranClub
//
//  Created by Николай on 12.05.2021.
//

import Foundation

class RestaurantsDetailsPresenter {
    
    weak var DetailViewController: RestaurantsDetailViewController?
    
    init(DetailViewController:  RestaurantsDetailViewController) {
        self.DetailViewController = DetailViewController
    }
    
    var restaurants: Restorant?
    
    func obtainRestoranById(id: String) {
        guard Reachability.isConnectedToNetwork() else {
            DetailViewController?.showError(title: "Ошибка", message: "Нет интернета", restoranNumber: id)
            return
        }
        
        guard var components = URLComponents(string: "http://f35e82e968cf.ngrok.io/restaurants_card_api") else {
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "rest_id", value: id)
        ]
        
        guard let url = components.url else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error == nil, let parsData = data {
                let CardResponse = try? JSONDecoder().decode(
                    Restorant.self,
                    from: parsData
                )
                
                self.restaurants = CardResponse
                DispatchQueue.main.async {
                    self.DetailViewController?.showRestaurants()
                }
            } else {
                self.DetailViewController?.showError(title: "Ошибка", message: "Что-то пошло не так!", restoranNumber: id)
            }
            
        }.resume()
    }
    
    func finishPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(Response.self, from: jsonData)
                print(parsedData)
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
 
}
