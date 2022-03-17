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
    let promoImage: [String]
    let profileImage: [String]
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
         promoImage: [String],
         profileImage: [String],
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
        self.promoImage = promoImage
        self.profileImage = profileImage
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
                      averageCheckRestaurant: 900,
                      location: "Петухова, 14",
                      image: ["http://abreview.ru/upload/iblock/78f/78f6c4bdf0f45d42c86f5bd86ee1003f.jpg"],
                      promoImage: ["https://burger-king-kupon.ru/wp-content/uploads/2022/02/1645087887_f501b2e5080f0f5d78d4314ee97296c3.png"],
                      profileImage: ["https://cdn.motor1.com/images/mgl/2WpWE/s3/rezultaty.jpg"],
                      rating: 3.2,
                      restaurantId: 1,
                      dish: "Замена поршня",
                      menu: "https://online.fliphtml5.com/ofedn/evdl/#p=1",
                      aboutRestaurant: "Каждый автомобилист знает, как важно в наше время найти своевременную и профессиональную помощь в ремонте автомобиля. Опытные автовладельцы отмечают, лучший вариант - ремонтировать и обслуживать авто в одном автосервисе.",
                      reviews: allFakeReview
                     ),
        FakeRestorant(restaurantName: "Центр Porsche",
                      descriptionRestaurant: "Мерседес до 200 наш клиент!",
                      averageCheckRestaurant: 1500,
                      location: "Чебышева, 14/6",
                      image: ["https://moneyinc.com/wp-content/uploads/2018/04/porsche-logo-emblem-3d-model-obj-ma-mb-750x422.jpg"],
                      promoImage: ["https://burger-king-kupon.ru/wp-content/uploads/2022/02/1645087887_f501b2e5080f0f5d78d4314ee97296c3.png"],
                      profileImage: ["https://cdn.motor1.com/images/mgl/2WpWE/s3/rezultaty.jpg"],
                      rating: 2.2,
                      restaurantId: 2,
                      dish: "Замена поршня",
                      menu: "https://online.fliphtml5.com/ofedn/evdl/#p=1",
                      aboutRestaurant: "Каждый автомобилист знает, как важно в наше время найти своевременную и профессиональную помощь в ремонте автомобиля. Опытные автовладельцы отмечают, лучший вариант - ремонтировать и обслуживать авто в одном автосервисе.",
                      reviews: allFakeReview
                     ),
        FakeRestorant(restaurantName: "LandRover World",
                      descriptionRestaurant: "Мерседес до 200 наш клиент!",
                      averageCheckRestaurant: 1500,
                      location: "Лагранжа, 324к2",
                      image: ["https://www.autodela.ru/assets/images/landrover-service.jpg"],
                      promoImage: ["https://burger-king-kupon.ru/wp-content/uploads/2022/02/1645087887_f501b2e5080f0f5d78d4314ee97296c3.png"],
                      profileImage: ["https://cdn.motor1.com/images/mgl/2WpWE/s3/rezultaty.jpg"],
                      rating: 5,
                      restaurantId: 2,
                      dish: "Замена поршня",
                      menu: "https://online.fliphtml5.com/ofedn/evdl/#p=1",
                      aboutRestaurant: "Каждый автомобилист знает, как важно в наше время найти своевременную и профессиональную помощь в ремонте автомобиля. Опытные автовладельцы отмечают, лучший вариант - ремонтировать и обслуживать авто в одном автосервисе.",
                      reviews: allFakeReview
                     )
    ]
}
