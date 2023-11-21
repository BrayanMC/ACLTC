//
//  UserServiceImpl.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

class UserServiceImpl: UserService {
    
    var repository: UserRepository = UserRepositoryImpl()
    
    func logIn(_ params: LogInParam, completion: @escaping (Result<Bool, CustomError>) -> Void) {
        repository.logIn(params) { result in
            completion(result)
        }
    }
    
    func signUp(_ params: SignUpParam, completion: @escaping (Result<Bool, CustomError>) -> Void) {
        repository.signUp(params) { result in
            completion(result)
        }
    }
}

