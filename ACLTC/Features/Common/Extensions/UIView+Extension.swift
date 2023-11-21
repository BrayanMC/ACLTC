//
//  UIView+Extension.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit
import SkeletonView

extension UIView {
    
    @IBInspectable
    var lookType: Int {
        get {
            return self.tag
        }
        set {
            self.tag = newValue
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
    public func addTapGesture(_ target: Any, action: Selector) {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }
    
    public func applyGradient() {
        /// Create a new gradient layer
        let gradientLayer = CAGradientLayer()
        
        /// Set the colors and locations for the gradient layer
        gradientLayer.colors = [
            UIColor(red: 0.392, green: 0.04, blue: 0.69, alpha: 1).cgColor,
            UIColor(red: 0.02, green: 0.2, blue: 0.59, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        /// Set the start and end points for the gradient layer
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.41)
        gradientLayer.endPoint = CGPoint(x: 1.29, y: 0.4)

        /// Set the frame to the layer
        gradientLayer.frame = self.bounds

        /// Add the gradient layer as a sublayer to the background view
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public func animateBottomSheet(show: Bool, onCompleted: (() -> Void)?) {
        if show {
            frame.origin.y += frame.height
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
                self.frame.origin.y -= self.frame.height
                if onCompleted != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        onCompleted!()
                    }
                }
            })
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
            self.frame.origin.y += self.frame.height
            self.animateOverlay()
            if onCompleted != nil{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    onCompleted!()
                }
            }
        })
    }
    
    public func animateOverlay(delay : TimeInterval = 0.0) {
        self.alpha = 0
        UIView.animate(withDuration: 0.2, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        })
    }
    
    public func roundTopCorners(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    public func isShimmer(_ isActive: Bool, cornerRadius: Float = 0, height: CGFloat = 0) {
        if isActive {
            if (height > 0) {
                SkeletonAppearance.default.multilineHeight = height
            }
            self.skeletonCornerRadius = cornerRadius
            self.isSkeletonable = true
            (self as? UILabel)?.linesCornerRadius = Int(cornerRadius)
            let skeletonLayer = SkeletonGradient(baseColor: ColorManager.shared.primary200)
            self.showAnimatedGradientSkeleton(usingGradient: skeletonLayer)
        } else {
            self.hideSkeleton()
        }
    }
}
