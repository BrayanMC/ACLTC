//
//  LocalRepositoryImpl.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

class LocalRepositoryImpl: LocalRepository {
    
    func email() -> String? {
        return LocalManager.shared.email
    }
    
    func email(_ value: String) {
        LocalManager.shared.email = value
    }
}
