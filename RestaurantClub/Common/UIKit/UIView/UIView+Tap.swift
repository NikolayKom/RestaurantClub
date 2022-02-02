//
//  UIView + Tap.swift
//  RestaurantClub
//
//  Created by Николай on 02.02.2022.
//

import UIKit

public struct AnimationConstants {
    
    static let kScaleDuration: TimeInterval = 0.1
}

extension UIView {
    
    public func touchBeganScaleAnimation() {
        UIView.animate(
            withDuration: AnimationConstants.kScaleDuration,
            delay: 0,
            options: AnimationOptions.curveEaseOut,
            animations: { [weak self] in
                self?.transform = CGAffineTransform.tapTransform
            },
            completion: nil)
    }
    
    public func touchEndedScaleAnimation(completion: (() -> Void)?) {
        UIView.animate(
            withDuration: AnimationConstants.kScaleDuration,
            delay: 0,
            options: AnimationOptions.curveEaseOut,
            animations: { [weak self] in
                self?.transform = CGAffineTransform.identity
            },
            completion: { (_) in
                completion?()
            })
    }
    
    public func tapScaleAnimation(completion: (() -> Void)?) {
        UIView.animate(
            withDuration: AnimationConstants.kScaleDuration,
            delay: 0,
            options: AnimationOptions.curveEaseOut,
            animations: { [weak self] in
                self?.transform = CGAffineTransform.tapTransform
            },
            completion: { (_) in
                completion?()
                UIView.animate(
                    withDuration: AnimationConstants.kScaleDuration,
                    animations: { [weak self] in
                        self?.transform = CGAffineTransform.identity
                    }, completion: nil)
            })
    }
}
