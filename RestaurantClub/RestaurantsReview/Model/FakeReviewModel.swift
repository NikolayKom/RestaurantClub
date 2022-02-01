//
//  FakeReviewModel.swift
//  RestaurantClub
//
//  Created by Николай on 01.02.2022.
//

import Foundation

struct FakeReview: Codable {
    let review: String
    let stars: Int
    let userName: String
    let date: String
    
    init(review: String,
         stars: Int,
         userName: String,
         date: String)
    {
        self.review = review
        self.stars = stars
        self.userName = userName
        self.date = date
    }
}
