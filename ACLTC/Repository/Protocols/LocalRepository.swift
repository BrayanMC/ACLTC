//
//  LocalRepository.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

protocol LocalRepository: AnyObject {
    func email(_ value: String)
    func email() -> String?
}

