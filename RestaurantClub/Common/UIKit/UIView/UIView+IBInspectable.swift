//
//  UIView+IBInspectable.swift
//  RestaurantClub
//
//  Created by Николай on 02.02.2022.
//

import UIKit

extension UIView {
    
    @IBInspectable public var sqCornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
}
