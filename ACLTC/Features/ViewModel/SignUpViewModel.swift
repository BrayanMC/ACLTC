//
//  SignUpViewModel.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import Foundation

enum SignUpError: Error {
    case emptyEmail
    case invalidEmail
    case emptyName
    case emptyLastName
    case emptyPassword
    case invalidPassword
}

final class SignUpViewModel: BaseViewModel {
    
    lazy var userService: UserService = UserServiceImpl()
    lazy var localService: LocalService = LocalServiceImpl()
    
    var signUpError: Observable<SignUpError> = Observable(nil)
    var signUpSuccess: Observable<Bool> = Observable(nil)
    var isValidEmail: Observable<Bool> = Observable(nil)
    var isValidName: Observable<Bool> = Observable(nil)
    var isValidLastName: Observable<Bool> = Observable(nil)
    var isValidPassword: Observable<Bool> = Observable(nil)
    
    func validateEmail(_ email: String) {
        if email.isEmpty {
            loading.value = false
            isValidEmail.value = false
            signUpError.value = SignUpError.emptyEmail
            return
        }
        
        if !email.isValidEmail {
            loading.value = false
            isValidEmail.value = false
            signUpError.value = SignUpError.invalidEmail
            return
        }
        
        isValidEmail.value = true
    }
    
    func validateName(_ name: String) {
        if name.isEmpty {
            loading.value = false
            isValidName.value = false
            signUpError.value = SignUpError.emptyName
            return
        }
        
        isValidName.value = true
    }
    
    func validateLastName(_ lastName: String) {
        if lastName.isEmpty {
            loading.value = false
            isValidLastName.value = false
            signUpError.value = SignUpError.emptyLastName
            return
        }
        
        isValidLastName.value = true
    }
    
    func validatePassword(_ password: String) {
        if password.isEmpty {
            loading.value = false
            isValidPassword.value = false
            signUpError.value = SignUpError.emptyPassword
            return
        }
        
        if password.count < GlobalConstants.minPasswordCharacters {
            loading.value = false
            isValidPassword.value = false
            signUpError.value = SignUpError.invalidPassword
            return
        }
        
        isValidPassword.value = true
    }
    
    func register(_ params: SignUpParam) {
        loading.value = true
        userService.signUp(params) { [weak self] result in
            guard self != nil else { return }
            self?.loading.value = false
            switch result {
            case .success(let data):
                UserDefaults.standard.setIsLoggedValue(true)
                self?.localService.email(params.email)
                self?.signUpSuccess.value = data
            case .failure(let error):
                switch error {
                case .notConnectedToInternet(let data):
                    self?.loading.value = false
                    self?.popUpError.value = self?.buildErrorPopUpViewData(
                        title: "POP_UP_NO_INTERNET_TITLE".localized,
                        description: data?.message ?? "",
                        type: .noInternet,
                        buttonTitle: "POP_UP_TRY_AGAIN_BUTTON_TITLE".localized,
                        completion: {
                            self?.register(params)
                        }
                    )
                default:
                    self?.loading.value = false
                    self?.popUpError.value = self?.buildErrorNotContemplatedPopUpViewData(
                        completion: {
                            self?.register(params)
                        }
                    )
                }
            }
        }
    }
}
