//
//  ReviewModel.swift
//  RestoranClub
//
//  Created by Николай on 21.05.2021.
//

import Foundation

struct Review: Codable {
    let review: String
    let stars: Int
    let userName: String
    let date: String

    enum CodingKeys: String,CodingKey {
        case review
        case stars
        case userName = "user_name"
        case date
    }
}
