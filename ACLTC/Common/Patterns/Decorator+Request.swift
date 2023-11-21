//
//  Decorator+Request.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

protocol DecoratorProtocol {
    func toDictionary() -> [String: Any]
}

extension DecoratorProtocol {
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        let mirror = Mirror(reflecting: self)
        
        for case let (label?, value) in mirror.children {
            if let convertibleValue = value as? DecoratorProtocol {
                dictionary[label] = convertibleValue.toDictionary()
            } else {
                dictionary[label] = value
            }
        }
        
        return dictionary
    }
}

