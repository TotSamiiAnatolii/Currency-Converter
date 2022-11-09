//
//  Formatter.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import Foundation

extension Formatter {
    
    static let formatter = NumberFormatter()
    
    static let formatterFrom: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
    
    static func formatToCurrency(maximumFractionDigits: Int ) -> NumberFormatter {
        formatter.roundingMode = .up
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.groupingSeparator = " "
        return formatter
    }
}

extension Numeric {
    
    var formatterFrom: String { Formatter.formatterFrom.string(for: self) ?? "" }

}
