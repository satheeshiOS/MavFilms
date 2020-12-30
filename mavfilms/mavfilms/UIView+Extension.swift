//
//  UIView+Extension.swift
//  mavfilms
//
//  Created by Satheesh Speed Mac on 31/12/20.
//

import Foundation
import UIKit

extension UIView {
    
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
}

class CustomDashedView: UIView {
   
    var yourViewBorder = CAShapeLayer()

    override func layoutSubviews() {
        super.layoutSubviews()
        yourViewBorder.removeFromSuperlayer()
        
        let yourBorder = CAShapeLayer()
        yourBorder.strokeColor = borderColor?.cgColor
        yourBorder.lineDashPattern = [2, 2]
        yourBorder.frame = self.bounds
        yourBorder.fillColor = nil
        yourBorder.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(yourBorder)
        self.yourViewBorder = yourBorder
        self.cornerRadius = cornerRadius
        self.clipsToBounds = true

        
    }
}
