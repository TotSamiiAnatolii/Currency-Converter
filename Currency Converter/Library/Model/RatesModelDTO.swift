//
//  RatesModelDTO.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import Foundation

struct DateModel: Codable {
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
    }
}

struct RatesModelDTO: Codable {
    var valute: [String: Valute]
    
    enum CodingKeys: String, CodingKey {
        case valute = "Valute"
    }
}

struct Rates: Codable {
    let previousDate: String?
    let previousURL: String?
    let date, timestamp: String?
    var valute: [String: Valute]

    enum CodingKeys: String, CodingKey {
        case previousDate = "PreviousDate"
        case previousURL = "PreviousURL"
        case date = "Date"
        case timestamp = "Timestamp"
        case valute = "Valute"
    }
}

struct Valute: Codable {
    let previous: Double
    let numCode, charCode: String
    let nominal: Int
    let name, id: String
    let value: Double
    var isSelected = false

    enum CodingKeys: String, CodingKey {
        case previous = "Previous"
        case numCode = "NumCode"
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case id = "ID"
        case value = "Value"
    }
}
