//
//  UIImageView + MyStyle.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

extension UIImageView {

    public func setMyStyle() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        return self
    }
    
    public func setImage(image: UIImage?) -> Self {
        self.image = image
        return self
    }

    public func setShadow(color: CGColor) -> Self {
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.1, height: 2.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 3
        self.layer.masksToBounds = false
        return self
    }
    
    public func setTintColor(color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
}
