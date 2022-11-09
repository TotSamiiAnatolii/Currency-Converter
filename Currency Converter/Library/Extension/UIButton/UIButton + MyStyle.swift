//
//  UIButton + MyStyle.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

extension UIButton {
    
    public typealias Func = () -> ()
    
    public func setMyStyle(cornerRadius: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = cornerRadius
        self.contentMode = .scaleAspectFill
        self.accessibilityTraits = [.keyboardKey]
        return self
    }
    
    public func setMyTitle(text: String, state: State) -> Self {
        self.setTitle(text, for: state)
        return self
    }
    
    public func setTarget( method methodDown: Selector, target: Any, event: UIControl.Event ) -> Self {

        self.addTarget(target, action: methodDown.self, for: event)
        
        return self
    }
    
    public func setShadow() -> Self {
        self.layer.shadowColor = Colors.shadow
        self.layer.shadowOffset = CGSize(width: 0.1, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 6
        self.layer.masksToBounds = false
        return self
    }
    
    public func addImage(image: UIImage?) -> Self {
        guard let image = image else {return self}
        self.setImage(image, for: .normal)
        return self
    }
    
    public func setStyleTitle(color: UIColor, font: UIFont) -> Self {
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = font
        return self
    }
}
