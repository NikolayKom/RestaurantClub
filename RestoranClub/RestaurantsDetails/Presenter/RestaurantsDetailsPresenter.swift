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
                    Restorant?.self,
                    from: parsData
                )
                
                self.restaurants = CardResponse
                DispatchQueue.main.async {
                    self.DetailViewController?.showRestaurants()
                }
                print(self.restaurants)
            } else {
                self.DetailViewController?.showError(title: "Ошибка", message: "Что-то пошло не так!", restoranNumber: id)
            }
            
        }.resume()
    }
    
    func sendReview() {
        let parameters = ["rest_id": 10,
                          "review": "jack",
                          "user_name": "oboregen",
                          "stars": 5
        ] as [String : Any]

            //create the url with URL
            let url = URL(string: "http://f35e82e968cf.ngrok.io/create_review/")! //change the url

            //create the session object
            let session = URLSession.shared

            //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }

            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }

                guard let data = data else {
                    return
                }

                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        print(json)
                        // handle json...
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
    }
 
