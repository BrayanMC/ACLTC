//
//  UserDefaults+Extensions.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLogged
    }
    
    public func setIsLoggedValue(_ value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLogged.rawValue)
        synchronize()
    }
    
    public func isLogged() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLogged.rawValue)
    }
    
    public func removeAll() {
        setIsLoggedValue(false)
    }
}

