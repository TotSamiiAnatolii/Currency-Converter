//
//  ConverterDataSourceDelegate.swift
//  Currency Converter
//
//  Created by USER on 08.11.2022.
//

import Foundation

protocol ConverterDataSourceDelegate: AnyObject  {
    
    func currencyRatioCalculation(to: Valute, baseFrom: Valute) -> String
    
    func calculateExchangeRate(to: Valute) -> String
    
    func deleteCurrencyInFavorite(index: Int)
    
    func addToValute()
    
    func setCharCode() -> String
    
    func updateView(currentCurrency: Valute?, date: DateModel?)
}
