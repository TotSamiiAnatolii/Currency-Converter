//
//  UIView + MyStyle.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

extension UIView {

    public func setStyle() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        return self
    }
    
    public func setRoundCorners(radius: CGFloat) -> Self {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        return self
    }
    
    public func setShadows(color: CGColor, width: CGFloat, height: CGFloat, radius: CGFloat, opacity: Float ) -> Self {
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
        return self
    }
}
