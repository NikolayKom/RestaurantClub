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
    FakeReview(review: "Жигу сделали пару раз пнув",
              stars: 1,
              userName: "Рамен",
              date: "02.01.22"),
    FakeReview(review: "Люблю этот сервис, качественно и быстро",
              stars: 5,
              userName: "Алексей",
              date: "02.01.22")
  ]
    // TODO: заставить рафика сделать координаты для карты 
    static let allFakeRestorant = [
        FakeRestorant(restaurantName: "Сервис у Ашота",
                      descriptionRestaurant: "Мерседес до 200 наш клиент!",
                      averageCheckRestaurant: 15000,
                      location: "Петухова, 14",
                      image: ["https://d1miefefncnroz.cloudfront.net/advt_photo/877150/1423139737_bebdcofceaad9mn.jpg"],
                      rating: 4.2,
                      restaurantId: 1,
                      dish: "Замена поршня",
                      menu: "https://online.fliphtml5.com/ofedn/evdl/#p=1",
                      aboutRestaurant: "Каждый автомобилист знает, как важно в наше время найти своевременную и профессиональную помощь в ремонте автомобиля. Опытные автовладельцы отмечают, лучший вариант - ремонтировать и обслуживать авто в одном автосервисе.",
                      reviews: allFakeReview
                     ),
        FakeRestorant(restaurantName: "Сервис не у Ашота ненеенненененне",
                      descriptionRestaurant: "Мерседес до 200 наш клиент!",
                      averageCheckRestaurant: 15000,
                      location: "Петухова, 14",
                      image: ["https://d1miefefncnroz.cloudfront.net/advt_photo/877150/1423139737_bebdcofceaad9mn.jpg"],
                      rating: 4.2,
                      restaurantId: 2,
                      dish: "Замена поршня",
                      menu: "https://online.fliphtml5.com/ofedn/evdl/#p=1",
                      aboutRestaurant: "Каждый автомобилист знает, как важно в наше время найти своевременную и профессиональную помощь в ремонте автомобиля. Опытные автовладельцы отмечают, лучший вариант - ремонтировать и обслуживать авто в одном автосервисе.",
                      reviews: allFakeReview
                     )
    ]
}
