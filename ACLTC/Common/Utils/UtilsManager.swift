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
}
