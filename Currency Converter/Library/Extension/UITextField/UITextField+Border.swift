//
//  UITextField+Border.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

extension UITextField {
    internal func addBottomBorder(height: CGFloat = 0.3, color: UIColor = #colorLiteral(red: 0.1450942443, green: 0.1569222876, blue: 0.1720681864, alpha: 1)) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        borderView.layer.shadowOpacity = 0.2
        borderView.layer.shadowRadius = 3.0
        self.addSubview(borderView)
        
        NSLayoutConstraint.activate([
                borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
                borderView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
