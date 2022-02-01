//
//  FakeRestaurants.swift
//  RestaurantClub
//
//  Created by Николай on 01.02.2022.
//

import UIKit

class FakeRestorant {
    let restaurantName: String
//    let reviews: [String]
    let descriptionRestaurant: String
    let averageCheckRestaurant: Int
    let location: String
    let image: [String]
    //let aboutRestaurant: String
    let rating: Double
    let restaurantId: Int
    let dish: String?
    let menu: String?
    let aboutRestaurant: String?
    let reviews: [FakeReview]?
    
    init(restaurantName: String,
         descriptionRestaurant: String,
         averageCheckRestaurant: Int,
         location: String,
         image: [String],
         rating: Double,
         restaurantId: Int,
         dish: String?,
         menu: String?,
         aboutRestaurant: String?,
         reviews: [FakeReview]?
    ) {
        self.restaurantName = restaurantName
        self.descriptionRestaurant = descriptionRestaurant
        self.averageCheckRestaurant = averageCheckRestaurant
        self.location = location
        self.image = image
        self.rating = rating
        self.restaurantId = restaurantId
        self.dish = dish
        self.menu = menu
        self.aboutRestaurant = aboutRestaurant
        self.reviews = reviews
    }
    
}

// MARK: - Restorant Sample Data
extension FakeRestorant {
  static let allFakeReview = [
    FakeReview(review: "Хожу каждый день ем одно и тоже",
              stars: 5,
              userName: "Настя",
              date: "02.01.22"),
    FakeReview(review: "Хожу каждый день ем одно и тоже Хожу каждый день ем одно и тоже Хожу каждый день ем одно и тожеХожу каждый день ем одно и тожеХожу каждый день ем одно и тоже Хожу каждый день ем одно и тоже ",
              stars: 5,
              userName: "Настя Настя НастяНастя Настя Настя",
              date: "02.01.22")
  ]
    
    static let allFakeRestorant = [
        FakeRestorant(restaurantName: "Том ям БАР",
                      descriptionRestaurant: "Лучше места не найти",
                      averageCheckRestaurant: 1500,
                      location: "Сердце Романовой, 5",
                      image: ["https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/2560px-Flag_of_the_United_States.svg.png"],
                      rating: 5.0,
                      restaurantId: 1,
                      dish: "Том ям",
                      menu: "Том ям",
                      aboutRestaurant: "Хаванина на каждый день",
                      reviews: allFakeReview
                     )
    ]
}
