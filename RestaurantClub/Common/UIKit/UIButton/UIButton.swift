//
//  UIButton.swift
//  RestaurantClub
//
//  Created by Николай on 02.02.2022.
//

import UIKit

extension UIButton {
    
    func sqSetBackgroundColor(_ color: UIColor?, forState state: UIControl.State) {
        self.setBackgroundImage(UIImage.sqWithColor(color), for: state)
    }
    
    func sqSetShadow() {
        let shadowColor = UIColor(red: 220, green: 220, blue: 220, alpha: 1)
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 16.0
    }
}
