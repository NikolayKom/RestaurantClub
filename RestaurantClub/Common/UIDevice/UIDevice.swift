//
//  UIDevice.swift
//  RestaurantClub
//
//  Created by Николай on 14.03.2022.
//
import UIKit
import Foundation

public enum FeedbackStyle {
    
    case buttonClicked
    case carPointChoosed
    case error
}

extension UIDevice {
    
    static func addFeedback(style: FeedbackStyle) {
        switch style {
        case .buttonClicked:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case .carPointChoosed:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }
}
