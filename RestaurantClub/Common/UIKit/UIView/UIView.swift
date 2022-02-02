//
//  UIView.swift
//  RestaurantClub
//
//  Created by Николай on 02.02.2022.
//
import UIKit

public extension Array where Element == UIColor? {

    static var orangeGradient = [
        UIColor(named: "OrangeOne"),
        UIColor(named: "OrangeTwo")
    ]
}

public enum GradientDirection {

    case topBottom
    case topLeftBottomRight
    case topRightBottomLeft
    case leftRight
    case customX(fromX: CGFloat, toX: CGFloat)
    case customY(fromY: CGFloat, toY: CGFloat)
    
    var pointsLayer: [CGPoint] {
        switch self {
        case .topBottom:
            return [CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1)]
            
        case .topLeftBottomRight:
            return [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1)]
            
        case .topRightBottomLeft:
            return [CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1)]
         
        case .leftRight:
            return [CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5)]

        case .customX(let fromX, let toX):
            return [CGPoint(x: fromX, y: 0.5), CGPoint(x: toX, y: 0.5)]
            
        case .customY(let fromY, let toY):
            return [CGPoint(x: 0.5, y: fromY), CGPoint(x: 0.5, y: toY)]
            
        }
    }
    
    func pointsView(size: CGSize) -> [CGPoint] {
        let width = size.width
        let height = size.height
        switch self {
        case .topBottom:
            return [CGPoint(x: width / 2, y: 0), CGPoint(x: width / 2, y: height)]
            
        case .topLeftBottomRight:
            return [.zero, CGPoint(x: width, y: height)]
            
        case .topRightBottomLeft:
            return [CGPoint(x: width, y: 0), CGPoint(x: 0, y: height)]
         
        case .leftRight:
            return [CGPoint(x: 0, y: height / 2), CGPoint(x: width, y: height / 2)]

        case .customX(let fromX, let toX):
            return [CGPoint(x: fromX, y: height / 2), CGPoint(x: toX, y: height / 2)]
            
        case .customY(let fromY, let toY):
            return [CGPoint(x: width / 2, y: fromY), CGPoint(x: width / 2, y: toY)]
        }
    }
}

extension GradientDirection: RawRepresentable {

    public typealias RawValue = String

    public var rawValue: String {
        switch self {
        case .topBottom: return .topBottom
        case .topLeftBottomRight: return .topLeftBottomRight
        case .topRightBottomLeft: return .topRightBottomLeft
        case .leftRight: return .leftRight
        case .customX: return .customX
        case .customY: return .customY
        }
    }

    public init?(rawValue: RawValue) {
        switch rawValue {
        case .topBottom: self = .topBottom
        case .topLeftBottomRight: self = .topLeftBottomRight
        case .topRightBottomLeft: self = .topRightBottomLeft
        case .leftRight: self = .leftRight
        case .customX: self = .customX(fromX: 0, toX: 1)
        case .customY: self = .customY(fromY: 0, toY: 1)
        default: return nil
        }
    }
}

extension UIView {
    
    class var sqIdentifier: String {
        return String(describing: self.classForCoder())
    }
    
    class var sqNib: UINib {
        return UINib(nibName: self.sqIdentifier, bundle: Bundle(for: self))
    }
    
    public var sqWidth: CGFloat {
        return self.frame.size.width
    }
    
    public var sqHeight: CGFloat {
        return self.frame.size.height
    }

    public var sqGradientLayer: CAGradientLayer? {
        (self.layer.sublayers ?? []).first(where: { $0 is CAGradientLayer }) as? CAGradientLayer
    }

    class func instance() -> Self {
        guard let view = UINib(
                nibName: self.sqIdentifier,
                bundle: nil
        ).instantiate(withOwner: self, options: nil).first as? Self else {
            fatalError("NOT FOUND XIB FOR \(self.sqIdentifier)")
        }
        return view
    }
    
    public func sqSetGradient(with colors: [UIColor?],
                              direction: GradientDirection = .topLeftBottomRight,
                              bounds: CGRect? = nil) {
        
        if self.sqGradientLayer != nil {
            self.removeGradientLayer()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0?.cgColor as Any }
        gradientLayer.startPoint = direction.pointsLayer.first ?? .zero
        gradientLayer.endPoint = direction.pointsLayer.last ?? .zero
        
        gradientLayer.locations = [0, 1]
        if let bounds = bounds {
            gradientLayer.frame = bounds
        } else {
            gradientLayer.frame = self.bounds
        }

        gradientLayer.cornerRadius = self.sqCornerRadius
        self.layer.addSublayer(gradientLayer)
        gradientLayer.zPosition = -1
    }
    
    public func removeGradientLayer() {
        if let layer = self.sqGradientLayer {
            layer.removeFromSuperlayer()
        }
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        if let nibName = type(of: self).description().components(separatedBy: ".").last {
            let nib = UINib(nibName: nibName, bundle: bundle)
            if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
                return view
            }
        }
        return UIView()
    }
    
    func sqRotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Float.pi * 2)
        rotation.duration = 1
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func sqBlink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
        }
    }
}

private extension String {

    static let topBottom = "topBottom"
    static let topLeftBottomRight = "topLeftBottomRight"
    static let topRightBottomLeft = "topRightBottomLeft"
    static let leftRight = "leftRight"
    static let customX = "customX"
    static let customY = "customY"
}
