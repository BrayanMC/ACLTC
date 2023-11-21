//
//  LocalService.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

protocol LocalService: AnyObject {
    func email(_ value: String)
    func email() -> String?
}
