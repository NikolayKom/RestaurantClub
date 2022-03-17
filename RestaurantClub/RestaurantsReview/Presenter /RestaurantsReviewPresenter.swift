//
//  RestaurantsReviewPresenter.swift
//  RestaurantClub
//
//  Created by Николай on 23.05.2021.
//

import Foundation

final class RestaurantsReviewPresenter {
    
    weak var viewController:  RestaurantsReviewViewController?
    
    init(viewController: RestaurantsReviewViewController) {
        self.viewController = viewController
    }
    
    func sendReview(NumberOfRestoran: String, textReview: String, userName: String, stars: Int) {
        let parameters = ["rest_id": NumberOfRestoran,
                          "review": "\(textReview)",
                          "user_name": "\(userName)",
                          "stars": stars
        ] as [String : Any]

            let url = URL(string: baseURL + "/create_review/")!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }

            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }

                guard let data = data else {
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
}
