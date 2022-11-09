//
//  ConverterValuteCell.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

struct ConverterValuteCell {
    
    let onAction: (()->())
    
    let nameValute: String
    
    let imageValute: UIImage?
    
    let charCode: String
    
    let value: String
    
    let rate: String

    let currentValuteCharCode: String
}
