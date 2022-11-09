//
//  ModelCurrencyToCell.swift
//  Currency Converter
//
//  Created by APPLE on 31.10.2022.
//

import UIKit

struct ModelCurrencyToCell {
    
    let countryFlag: UIImage?
    
    let chareCode: String
    
    let nameCurrency: String
    
    let rates: Double
    
    let arrowUp = Images.up
    
    let arrowDown = Images.down
    
    var isSelected: Bool
}
