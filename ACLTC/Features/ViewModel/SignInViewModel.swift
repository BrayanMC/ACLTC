//
//  SignInViewModel.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import Foundation

enum SignInError: Error {
    case emptyEmail
    case invalidEmail
    case emptyPassword
    case invalidPassword
}

final class SignInViewModel: BaseViewModel {
    
    lazy var userService: UserService = UserServiceImpl()
    lazy var localService: LocalService = LocalServiceImpl()
    
    var sessionEmail: Observable<String> = Observable(nil)
    var logInSuccess: Observable<Bool> = Observable(nil)
    var logInError: Observable<SignInError> = Observable(nil)
    var isValidEmail: Observable<Bool> = Observable(nil)
    var isValidPassword: Observable<Bool> = Observable(nil)
    var goToRegister: Observable<Bool> = Observable(nil)
    
    func validateSession() {
        if (UserDefaults.standard.isLogged()) {
            sessionEmail.value = localService.email()
        }
    }
    
    func validateEmail(_ email: String) {
        if email.isEmpty {
            loading.value = false
            isValidEmail.value = false
            logInError.value = SignInError.emptyEmail
            return
        }
        
        if !email.isValidEmail {
            loading.value = false
            isValidEmail.value = false
            logInError.value = SignInError.invalidEmail
            return
        }
        
        isValidEmail.value = true
    }
    
    func validatePassword(_ password: String) {
        if password.isEmpty {
            loading.value = false
            isValidPassword.value = false
            logInError.value = SignInError.emptyPassword
            return
        }
        
        if password.count < GlobalConstants.minPasswordCharacters {
            loading.value = false
            isValidPassword.value = false
            logInError.value = SignInError.invalidPassword
            return
        }
        
        isValidPassword.value = true
    }
    
    func logIn(_ params: LogInParam) {
        loading.value = true
        userService.logIn(params) { [weak self] result in
            guard self != nil else { return }
            self?.loading.value = false
            switch result {
            case .success(let data):
                UserDefaults.standard.setIsLoggedValue(true)
                self?.localService.email(params.email)
                self?.logInSuccess.value = data
            case .failure(let error):
                switch error {
                case .unAuthorized(let data):
                    print("Error: \(String(describing: data))")
                    self?.popUpError.value = self?.buildErrorPopUpViewData(
                        title: "POP_UP_UNAUTHORIZED_ERROR_POP_UP_TITLE".localized,
                        description: data?.message ?? "",
                        buttonTitle: "POP_UP_GO_TO_REGISTER_BUTTON_TITLE".localized,
                        completion: {
                            self?.goToRegister.value = true
                        }
                    )
                case .notConnectedToInternet(let data):
                    self?.loading.value = false
                    self?.popUpError.value = self?.buildErrorPopUpViewData(
                        title: "POP_UP_NO_INTERNET_TITLE".localized,
                        description: data?.message ?? "",
                        type: .noInternet,
                        buttonTitle: "POP_UP_TRY_AGAIN_BUTTON_TITLE".localized,
                        completion: {
                            self?.logIn(params)
                        }
                    )
                default:
                    self?.loading.value = false
                    self?.popUpError.value = self?.buildErrorNotContemplatedPopUpViewData(
                        completion: {
                            self?.logIn(params)
                        }
                    )
                }
            }
        }
    }
}
