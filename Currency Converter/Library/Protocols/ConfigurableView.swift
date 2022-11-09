//
//  ConfigurableView.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import Foundation

protocol ConfigurableView {
    
    associatedtype Model
    
    func configure(with model: Model)
}
