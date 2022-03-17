//
//  FakePromos.swift
//  RestaurantClub
//
//  Created by Николай on 16.03.2022.
//

import UIKit

class FakePromo {
    let promoImage: UIImage?
    let restaurantId: Int
    
    init(promoImage: UIImage?,
         restaurantId: Int
    ) {
        self.promoImage = promoImage
        self.restaurantId = restaurantId
    }
}

extension FakePromo {
    static let allFakePromo = [
        FakePromo(promoImage: R.image.promoVaz(),
                  restaurantId: 1),
        FakePromo(promoImage: R.image.promoPorche(),
                  restaurantId: 2),
        FakePromo(promoImage: R.image.promoLandRover(),
                  restaurantId: 2)
    ]

}
