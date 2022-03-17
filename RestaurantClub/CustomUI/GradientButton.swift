//
//  GradientButton.swift
//  RestaurantClub
//
//  Created by Николай on 02.02.2022.
//

import UIKit

class GradientButton: UIButton {

    public var gradientEnabled = true
    public var gradientColors: [UIColor?] = .orangeGradient
    public var gradientDisabledColors: [UIColor?] = .grayGradient
    public var gradientPurple: [UIColor?] = .purpleGradient

    public var highlightEnabled = false

    internal var loader: UIActivityIndicatorView?

    private var textColor: UIColor?

    override open var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            self.titleLabel?.alpha = 1
            if self.highlightEnabled {
                self.sqGradientLayer?.opacity = newValue ? 0.7 : 1
            }
        }
    }

    private var enableLoader = false
    @IBInspectable var isLoaderEnabled: Bool {
        get {
            return self.enableLoader
        }
        set {
            self.enableLoader = newValue
            if newValue {
                self.addLoader()
            } else {
                self.loader?.removeFromSuperview()
            }
        }
    }
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
    }
    
// MARK: - Initial setup
    private func setup() {
        self.sqSetBackgroundColor(UIColor(named: R.string.colors.sosButtonBackground()), forState: .disabled)
        self.adjustsImageWhenHighlighted = false
        self.showsTouchWhenHighlighted = false
        self.textColor = self.titleLabel?.textColor
    }
    
// MARK: - Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if self.gradientEnabled {
            self.sqSetGradient(with: self.gradientPurple, direction: .topBottom)
        } else {
            self.removeGradientLayer()
        }
    }
    
    private func addLoader() {
        self.loader = UIActivityIndicatorView()
        self.loader?.color = self.tintColor
        self.loader?.hidesWhenStopped = true
        self.addSubview(self.loader ?? UIView())
        
        self.loader?.translatesAutoresizingMaskIntoConstraints = false
        self.loader?.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.loader?.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.loader?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.loader?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
// MARK: - Set Enabled
    func setEnabled(_ enabled: Bool) {
        self.isEnabled = enabled
        
        if enabled && self.gradientEnabled {
            self.sqSetGradient(with: self.gradientPurple, direction: .topBottom)
        } else {
            self.removeGradientLayer()
        }
        
        self.layoutIfNeeded()
    }
    
// MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.touchBeganScaleAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.touchEndedScaleAnimation {
            self.sendActions(for: .touchUpInside)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchEndedScaleAnimation(completion: nil)
    }
    
// MARK: - Loader
    func setLoaderVisible(_ visible: Bool) {
        if !self.isLoaderEnabled { return }

        if visible {
            self.loader?.startAnimating()
            self.setTitleColor(.clear, for: .normal)
        } else {
            self.loader?.stopAnimating()
            self.setTitleColor(self.textColor, for: .normal)
        }
    }
}
