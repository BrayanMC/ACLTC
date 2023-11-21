//
//  ACLTextFieldType.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

public enum ACLTextFieldType {
    case Business(maxCharacters: Int)
    case Email(maxCharacters: Int = 0)
    case Password(minCharacters: Int = 0, maxCharacters: Int = 0)
    case Name
    case LastName
    case DocumentNumber(documentType: Int)
    case CellPhoneNumber(maxCharacters: Int)
    case OTP(maxCharacters: Int)
    case CardNumber(maxCharacters: Int)
    case CVVCode(maxCharacters: Int)
    case Account(maxCharacters: Int)
    case Date
    case Search
    case Default
}

