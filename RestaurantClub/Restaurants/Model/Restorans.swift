//
//  Restorans.swift
//  RestoranClub
//
//  Created by Николай on 04.05.2021.
//

import Foundation

struct RestorantsResponse: Codable {
    let restorants: [Restorant]
    
    enum CodingKeys: String,CodingKey {
        case restorants = "data"
	}
}


struct Restorant: Codable {
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
    let reviews: [Review]?

    enum CodingKeys: String,CodingKey {
        case restaurantName = "restaurant_name"
//        case reviews
        case descriptionRestaurant = "description_restaurant"
        case averageCheckRestaurant = "average_check_restaurant"
        case location
        case image
        //case aboutRestaurant = "about_restaurant"
        case rating
        case restaurantId = "restaurant_id"
		case dish
        case menu
        case aboutRestaurant = "about_restaurant"
        case reviews
    }
}

