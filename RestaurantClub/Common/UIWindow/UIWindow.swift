//
//  UIWindow.swift
//  RestaurantClub
//
//  Created by Николай on 17.02.2022.
//

import UIKit

extension UIWindow {
    
    static var sqKeyWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
    
    static var sqTopMostViewController: UIViewController? {
        guard var topController = UIWindow.sqKeyWindow?.rootViewController else {
            return nil
        }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
            
        }
        
        return topController
    }
}
