//
//  Constants.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

public enum GlobalConstants {
    public static let maxByDefaultAmount = 10000.00
    public static let maxByDefaultDecimalsInAmount = 2
    public static let maxCCIDigits = 20
    public static let maxBusinessDigits = 11
    public static let minPasswordCharacters = 8
    public static let platformCode = "IOS"
    public static let bancomBankCode = "023"
}

public enum ExchangeRateOperationConstants {
    public static let amountValue = 20.00
    public static let minAmountValue = 20.00
    public static let maxAmountValue = 30000.00
}

public enum DocumentTypeLocalIds {
    public static let None = 0
    public static let DNI = 1
}

public enum DocumentTypeMaxCharacters {
    public static let DNI = 8
}

public enum DateFormats {
    public static let ddMMMMyyy = "dd MMMM yyyy"
    public static let dd_MM_yyyy = "dd-MM-yyyy"
}

public enum CurrencyCode: String {
    case pen = "PEN"
    case dollar = "USD"
}

public enum CodeType: String {
    case tc = "TC"
}

public enum OperationStatus: String {
    case completedSuccessfully = "FS"
    case pending = "P"
    case cancelled = "C"
}

public enum ErrorCodes {
    public static let NOT_REGISTERED_ERROR_CODE = "01"
}
