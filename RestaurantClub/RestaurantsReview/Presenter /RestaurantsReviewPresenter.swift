//
//  RestaurantsReviewPresenter.swift
//  RestaurantClub
//
//  Created by Николай on 23.05.2021.
//

import Foundation

class RestaurantsReviewPresenter {
    
    weak var viewController:  RestaurantsReviewViewController?
    
    init(viewController: RestaurantsReviewViewController) {
        self.viewController = viewController
    }
    
    let reviewArray = ["Ужасно","Плохо","Среднего качества", "Вкусно", "Очень вкусно","Изумительно"]
    
    
    func sendReview(NumberOfRestoran: String, textReview: String, userName: String, stars: Int) {
        let parameters = ["rest_id": NumberOfRestoran,
                          "review": "\(textReview)",
                          "user_name": "\(userName)",
                          "stars": stars
        ] as [String : Any]

            //create the url with URL
            let url = URL(string: baseURL + "/create_review/")! //change the url

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
