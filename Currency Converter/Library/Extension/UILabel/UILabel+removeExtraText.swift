//
//  UILabel+removeExtraText.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

extension UILabel {
    
    func removeExtraText() {
        guard let arrayText = self.text?.trimmingCharacters(in: .whitespaces).components(separatedBy: .whitespaces) else {return}
        
        if arrayText.count >= 2 {
            self.text = "\(arrayText[0])  \(arrayText[1])"
        } else {
            self.text = "\(arrayText[0])"
        }
    }
}
