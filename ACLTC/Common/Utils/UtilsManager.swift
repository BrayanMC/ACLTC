//
//  UtilsManager.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

public class UtilsManager {
    
    public static let shared: UtilsManager = UtilsManager()
    
    private init() { }

    public static func isValueBetweenTheLimits(_ value: Double, max: Double = GlobalConstants.maxByDefaultAmount) -> Bool {
        return !(value > max || value < 0.0)
    }
    
    public static func formatDateToString(date: Date, toFormat: String = DateFormats.dd_MM_yyyy) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = toFormat
        return formatter.string(from: date)
    }
    
    public static func formatDate(date: String, toFormat: String = DateFormats.dd_MM_yyyy) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = toFormat
        if (formatter.date(from: date) != nil) {
            return formatter.date(from: date)!
        } else {
            return Date()
        }
    }
    
    public static func getCurrencyCodeBy(_ currencyName: String) -> String {
        switch currencyName {
        case "SOLES":
            return CurrencyCode.pen.rawValue
        case "DOLARES":
            return CurrencyCode.dollar.rawValue
        default:
            return ""
        }
    }
}
