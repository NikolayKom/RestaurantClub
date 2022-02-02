//
//  UIImage.swift
//  RestaurantClub
//
//  Created by Николай on 02.02.2022.
//

import UIKit

extension UIImage {
    
// MARK: - Image With Color
    class func sqWithColor(_ color: UIColor?,
                           rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color?.setFill()
        
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
