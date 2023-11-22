//
//  UserRepositoryImpl.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import Foundation

class UserRepositoryImpl: UserRepository {
    
    func logIn(_ params: LogInParam, completion: @escaping (Result<Bool, CustomError>) -> Void) {
        if (params.email == TestLogIn.email && params.password == TestLogIn.password) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                debugPrint("you have logged in successfully ✅")
                debugPrint(params.toDictionary())
                completion(.success(true))
            }
        } else {
            let errorResponse = ErrorResponse(
                message: "Los datos ingresados no están registrados en EQ APP. Te invitamos a registrarte.",
                debugMessage: "",
                timestamp: "",
                code: "",
                httpStatus: ""
            )
            completion(.failure(.unAuthorized(errorResponse)))
        }
    }
    
    func signUp(_ params: SignUpParam, completion: @escaping (Result<Bool, CustomError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            debugPrint("has been successfully registered ✅")
            debugPrint(params.toDictionary())
            completion(.success(true))
        }
    }
}
