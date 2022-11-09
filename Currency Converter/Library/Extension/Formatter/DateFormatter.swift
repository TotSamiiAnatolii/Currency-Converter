//
//  DateFormatter.swift
//  Currency Converter
//
//  Created by APPLE on 31.10.2022.
//

import UIKit

enum GetDate: String {
    case weekDay = "dd EEEE"
    case timeUpdate = "HH:mm"
}

extension DateFormatter {
    
    static let dateFormatter = DateFormatter()
    
    static  func getWeekDay(date: String?, type: GetDate) -> String {
        let formatDate = type.rawValue
        guard let date = date else { return "" }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        dateFormatter.timeZone = TimeZone.current
        guard let date = dateFormatter.date(from: date) else { return ""}
        dateFormatter.dateFormat = formatDate
        return dateFormatter.string(from: date)
    }
}

