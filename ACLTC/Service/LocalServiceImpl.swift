//
//  LocalServiceImpl.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

class LocalServiceImpl: LocalService {
    
    let repository: LocalRepository = LocalRepositoryImpl()
    
    func email() -> String? {
        return repository.email()
    }
    
    func email(_ value: String) {
        repository.email(value)
    }
}
