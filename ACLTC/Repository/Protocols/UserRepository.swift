//
//  UserRepository.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

protocol UserRepository: AnyObject {
    func logIn(_ params: LogInParam, completion: @escaping (Result<Bool, CustomError>) -> Void)
}
