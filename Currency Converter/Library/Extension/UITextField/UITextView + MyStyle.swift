//
//  UITextView + MyStyle.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

extension UITextField {

    public func setMyStyle(textAligment: NSTextAlignment, font: UIFont) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = textAligment
        self.borderStyle = .none
        self.font = font
        self.backgroundColor = Colors.mainBackground
        self.addBottomBorder()
        return self
    }
    
    public func setLeftViewMode(viewMode: UITextField.ViewMode, view: UIView) -> Self {
        self.leftViewMode = viewMode
        self.leftView = view
        
        return self
    }
    
    public func setTarget(method: Selector, target: Any, event: UIControl.Event) -> Self {
        self.addTarget(target, action: method, for: event)
        return self
    }
}
