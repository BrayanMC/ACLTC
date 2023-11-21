//
//  UserRepositoryImpl.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

class UserRepositoryImpl: UserRepository {
    
    func logIn(_ params: LogInParam, completion: @escaping (Result<Bool, CustomError>) -> Void) {
        if (params.email == TestUser.email && params.password == TestUser.password) {
            completion(.success(true))
        } else {
            let errorResponse = ErrorResponse(
                message: "Los datos ingresados no están registrados en Cambix. Te invitamos a registrarte.",
                debugMessage: "",
                timestamp: "",
                code: "",
                httpStatus: ""
            )
            completion(.failure(.unAuthorized(errorResponse)))
        }
    }
}
