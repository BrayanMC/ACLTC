//
//  String+Extension.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

extension String {
    
    static var empty = ""
    
    public var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
    
    public var capitalizedAllWords: String {
        let sentence = self.lowercased()
        let words = sentence.components(separatedBy: " ")
        let capitalized = words.map { $0.capitalized }.joined(separator: " ")
        return capitalized
    }
    
    public var getFirstWord: String {
        let sentence = self.lowercased()
        let words = sentence.components(separatedBy: " ")
        if let firstWord = words.first {
            let capitalized = firstWord.capitalized
            return capitalized
        }
        return ""
    }
    
    public var localized: String {
        NSLocalizedString(self, comment: self)
    }
    
    private func convertHtmlToNSAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        return try? NSAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )
    }
    
    public func stripHTMLTags() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        do {
            let attributedString = try NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html],
                                                          documentAttributes: nil)
            let plainText = attributedString.string
            return plainText
        } catch {
            print("Error stripping HTML tags: \(error)")
            return nil
        }
    }
    
    public func extractContentBetweenBTags() -> [String] {
        /// Regular expression to find content between <b> and </b> tags
        let regex = try! NSRegularExpression(pattern: "<b>(.*?)</b>", options: .caseInsensitive)
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        /// Extract content between <b> and </b> tags
        var results: [String] = []
        for match in matches {
            if let range = Range(match.range(at: 1), in: self) {
                let content = String(self[range])
                results.append(content)
            }
        }
        return results
    }
    
    public func convertHtmlToAttributedStringWithCSS(font: UIFont?) -> NSAttributedString? {
        guard let _font = font else {
            return convertHtmlToNSAttributedString()
        }
        let modifiedString = "<style>body{font-family: '\(_font.fontName)'; font-size:\(_font.pointSize)px; }</style>\(self)"
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    public func addAttributeText(color: UIColor = ColorManager.shared.black400, font: UIFont, isUnderline: Bool = false) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
            .addAttributeText(color: color, font: font, isUnderline: isUnderline)
    }
    
    public func addAttributeText(text: String, color: UIColor = ColorManager.shared.black400, font: UIFont, isUnderline: Bool = false) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
            .addAttributeText(textFind: text, color: color, font: font, isUnderline: isUnderline)
    }
    
    public func addAttributeText(texts: [String], color: UIColor = ColorManager.shared.black400, font: UIFont, isUnderline: Bool = false) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
            .addMultipleTextAttributes(textsToFind: texts, color: color, font: font, isUnderline: isUnderline)
    }
    
    public func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = NSLocale(localeIdentifier: "es_PE") as Locale?
        formatter.maximumFractionDigits = GlobalConstants.maxByDefaultDecimalsInAmount
        formatter.minimumFractionDigits = GlobalConstants.maxByDefaultDecimalsInAmount
        formatter.currencySymbol = ""
        formatter.groupingSeparator = ""
        var amountWithPrefix = self
        
        /// remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        /// if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return "0.00"
        }
        
        return formatter.string(from: number)!
    }
    
    public var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    public var isAlphanumericWithSpace: Bool {
        return !isEmpty && range(of: "[^A-zÀ-ú-Z0-9_ ]", options: .regularExpression) == nil
    }
    
    public var isFormatValidEmail: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9@._-]+", options: .regularExpression) == nil
    }
    
    public var isFormatName: Bool {
        return !isEmpty && range(of: "[^a-zñáéíóúA-ZÑÁÉÍÓÚ ]+", options: .regularExpression) == nil
    }
    
    public var isOnlyNumeric:Bool {
        return !isEmpty && range(of: "[^[0-9]]", options: .regularExpression) == nil
    }
    
    private enum StringValidation {
        case email
        case phoneNumber
        case cellPhoneNumber
        case capitalLetter
        case number
        case specialCharacter
        case onlyText
        case otp
        case password
    }

    private func isValid(type: StringValidation) -> Bool {
        var regularExp = ""
        switch type {
        case .email:
            regularExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .phoneNumber:
            regularExp = "[0][0-9]{8}"
        case .cellPhoneNumber:
            regularExp = "[9][0-9]{8}"
        case .capitalLetter:
            regularExp = ".*[A-Z]+.*"
        case .number:
            regularExp = ".*[0-9]+.*"
        case .specialCharacter:
            regularExp = ".*[!&^%$#@()/]+.*"
        case .onlyText:
            regularExp = "[^a-zñáéíóúA-ZÑÁÉÍÓÚ]+"
        case .otp:
            regularExp = ".{6}"
        case .password:
            regularExp = ".{4}"
        }
        let test = NSPredicate(format: "SELF MATCHES %@", regularExp)
        return test.evaluate(with: self)
    }
    
    public var isValidEmail: Bool {
        return self.isValid(type: .email)
    }
    
    public var isValidPhoneNumber: Bool {
        return self.isValid(type: .phoneNumber)
    }

    public var isValidCellPhoneNumber: Bool {
        return self.isValid(type: .cellPhoneNumber)
    }
    
    public var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespaces)
            return trimmed.isEmpty
        }
    }
    
    public var hasUppercaseAndLowercaseLetters: Bool {
        return self.isValid(type: .capitalLetter)
    }
    
    public var hasNumbers: Bool {
        return self.isValid(type: .number)
    }
    
    var hasSpecialCharacters: Bool {
        return self.isValid(type: .specialCharacter)
    }
    
    public var isPasswordCorrect: Bool {
        print("\(self) hasUppercaseAndLowercaseLetters: \(hasUppercaseAndLowercaseLetters)")
        print("\(self) hasNumbers: \(hasNumbers)")
        print("\(self) hasSpecialCharacters: \(hasSpecialCharacters)")
        return hasUppercaseAndLowercaseLetters && hasNumbers && hasSpecialCharacters
    }
    
    public var isValidOTP: Bool {
        return self.isValid(type: .otp)
    }
    
    public var isValidPassword: Bool {
        return self.isValid(type: .password)
    }
    
    public func hasEmoticon() -> Bool {
        return self.containsEmoji
    }
    
    public var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                0x1F680...0x1F6FF, // Transport and Map
                0x2600...0x26FF, // Misc symbols
                0x2700...0x27BF, // Dingbats
                0xFE00...0xFE0F, // Variation Selectors
                0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                0x1F1E6...0x1F1FF,
                127000...127600, // Various asian characters
                65024...65039, // Variation selector
                9100...9300, // Misc items
                8400...8447: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }
    
    public func removeWhitespaceAndDashes() -> String {
        self.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
    }
    
    public func toCurrencySymbol() -> String {
        switch self {
        case CurrencyCode.pen.rawValue:
            return "S/"
        case CurrencyCode.dollar.rawValue:
            return "$"
        default:
            return ""
        }
    }
    
    public func dateUnformattedToDateTimePattern() -> String {
        let dateTimePattern = "dd/MM/yy',' hh:mm a"
        if !self.isEmpty {
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            isoDateFormatter.formatOptions = [
                .withFullDate,
                .withFullTime,
                .withDashSeparatorInDate,
                .withFractionalSeconds]
            if let currentDate = isoDateFormatter.date(from: self) {
                let dateFormatter = DateFormatter()
                dateFormatter.amSymbol = "am"
                dateFormatter.pmSymbol = "pm"
                dateFormatter.dateFormat = dateTimePattern
                return dateFormatter.string(from: currentDate)
            }
        }
        return "N/A"
    }
}
