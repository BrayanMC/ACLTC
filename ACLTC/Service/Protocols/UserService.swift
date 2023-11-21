//
//  UserService.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

protocol UserService: AnyObject {
    func logIn(_ params: LogInParam, completion: @escaping (Result<Bool, CustomError>) -> Void)
    func signUp(_ params: SignUpParam, completion: @escaping (Result<Bool, CustomError>) -> Void)
}
