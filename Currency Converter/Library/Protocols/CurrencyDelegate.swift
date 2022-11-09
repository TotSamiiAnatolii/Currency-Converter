//
//  CurrencyDelegate.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import Foundation

protocol CurrencyDelegate {
    
    func removeFromFavorites(index: Int)
    
    func addInFavorite(index: Int)
    
    func addCurrencyFrom(value: Valute)
    
    func updateCurrencyFrom(value: [Valute])
}
