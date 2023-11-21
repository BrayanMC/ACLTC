//
//  ACLTextField+UITextFieldDelegate.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

extension ACLTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (!self.isEmojiAllowed && string.hasEmoticon()) {
            return false
        }
        
        switch textFieldType {
        case .Business(let maxCharacters):
            if (!ValidationsManager.isAtLimit(existingText: textField.text!.replacingOccurrences(of: ".", with: ""), newText: string.replacingOccurrences(of: ".", with: ""), limit: maxCharacters)) {
                return false
            }
            
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            
            return true
        case .Email(let maxCharacters):
            if (maxCharacters != 0) {
                if (!ValidationsManager.isAtLimit(existingText: textField.text!.replacingOccurrences(of: ".", with: ""), newText: string.replacingOccurrences(of: ".", with: ""), limit: maxCharacters)) {
                    return false
                }
            }
            
            guard CharacterSet(charactersIn: "0123456789QWERTYUIOPASDFGHJKLÑZXCVBNMqwertyuiopasdfghjklñzxcvbnm.@_-").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            
            return true
        case .Password(_, let maxCharacters):
            if (maxCharacters != 0) {
                if (!ValidationsManager.isAtLimit(existingText: textField.text!.replacingOccurrences(of: ".", with: ""), newText: string.replacingOccurrences(of: ".", with: ""), limit: maxCharacters)) {
                    return false
                }
            }
            
            switch keyboardType {
            case .Numeric:
                guard CharacterSet(charactersIn: "0987654321QWERTYUIOPASDFGHJKLÑZXCVBNMqwertyuiopasdfghjklñzxcvbnm").isSuperset(of: CharacterSet(charactersIn: string)) else {
                    return false
                }
                break
            case .Alphanumeric:
                guard CharacterSet(charactersIn: "0123456789QWERTYUIOPASDFGHJKLÑZXCVBNMqwertyuiopasdfghjklñzxcvbnm").isSuperset(of: CharacterSet(charactersIn: string)) else {
                    return false
                }
                break
            default:
                break
            }
            
            return true
        case .Name, .LastName:
            guard let text = textField.text else { return false }
            if text.isEmpty && string == " " { return false }
            if text.last == " " && string == " " { return false }
            
            guard CharacterSet(charactersIn: "QWERTYUIOPASDFGHJKLÑZXCVBNMqwertyuiopasdfghjklñzxcvbnm ").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            
            return true
        case .DocumentNumber:
            var charactersIn = ""
            switch (self.documentTypeSelected) {
            case DocumentTypeLocalIds.DNI:
                self.maxOfCharacters = DocumentTypeMaxCharacters.DNI
                charactersIn = "0987654321"
                break
            default:
                break
            }
            
            if (!ValidationsManager.isAtLimit(existingText: textField.text!.replacingOccurrences(of: ".", with: ""), newText: string.replacingOccurrences(of: ".", with: ""), limit: self.maxOfCharacters)) {
                return false
            }
            
            guard CharacterSet(charactersIn: charactersIn).isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            
            return true
        case .CellPhoneNumber(let maxCharacters):
            if (!ValidationsManager.isAtLimit(existingText: textField.text!.replacingOccurrences(of: ".", with: ""), newText: string.replacingOccurrences(of: ".", with: ""), limit: maxCharacters)) {
                return false
            }
            
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            
            return true
        case .OTP(let maxCharacters):
            if (!ValidationsManager.isAtLimit(existingText: textField.text!.replacingOccurrences(of: ".", with: ""), newText: string.replacingOccurrences(of: ".", with: ""), limit: maxCharacters)) {
                return false
            }
            
            guard CharacterSet(charactersIn: "0123456789QWERTYUIOPASDFGHJKLÑZXCVBNMqwertyuiopasdfghjklñzxcvbnm").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            
            return true
        case .CardNumber(let maxCharacters):
            if (!ValidationsManager.isAtLimit(existingText: textField.text!.replacingOccurrences(of: ".", with: ""), newText: string.replacingOccurrences(of: ".", with: ""), limit: maxCharacters)) {
                return false
            }
            
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
               
                return false
            }
            
            return true
        case .CVVCode(let maxCharacters):
            if (!ValidationsManager.isAtLimit(existingText: textField.text!.replacingOccurrences(of: ".", with: ""), newText: string.replacingOccurrences(of: ".", with: ""), limit: maxCharacters)) {
                return false
            }
            
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            
            return true
        case .Account(let maxCharacters):
            if (!ValidationsManager.isAtLimit(existingText: textField.text!.removeWhitespaceAndDashes(), newText: string.removeWhitespaceAndDashes(), limit: maxCharacters)) {
                return false
            }
            
            let newString = string.removeWhitespaceAndDashes()
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: newString)) else {
                return false
            }
            
            return true
        case .Date:
            guard CharacterSet(charactersIn: "0123456789/").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            
            return true
        case .Search:
            return true
        case .Default:
            if (self.maxOfCharacters != 0) {
                if (!ValidationsManager.isAtLimit(existingText: textField.text!, newText: string, limit: self.maxOfCharacters)) {
                    return false
                } else {
                    return true
                }
            } else {
                return true
            }
        }
    }
}
