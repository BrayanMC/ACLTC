//
//  LocalManager.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import KeychainAccess

class LocalManager {
    
    static let shared: LocalManager = {
        return LocalManager()
    }()
    
    private let keychain = Keychain(service: "com.bmc.acltc")
    private let emailKey = "email"
    private let passwordKey = "password"
    private let tokenKey = "token"
    
    private init() {}
    
    public var email: String? {
        get {
            return keychain[string: emailKey]
        }
        set {
            keychain[string: emailKey] = newValue
        }
    }

    public var password: String? {
        get {
            return keychain[string: passwordKey]
        }
        set {
            keychain[string: passwordKey] = newValue
        }
    }
    
    public func clearCredentials() {
        try? keychain.remove(emailKey)
        try? keychain.remove(passwordKey)
        try? keychain.remove(tokenKey)
    }
}
