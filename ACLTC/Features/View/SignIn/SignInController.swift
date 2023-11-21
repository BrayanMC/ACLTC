//
//  SignInController.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

class SignInController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var emailACLTextField: ACLTextField!
    @IBOutlet weak var passwordACLTextField: ACLTextField!
    @IBOutlet weak var signUpLabel: UILabel!
    
    private let signUpText: String = "Regístrate aquí"
    private lazy var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        addGesturesToLabels()
        bind()
        hideKeyboardWhenTappedAround()
        viewModel.validateSession()
    }
    
    private func initViews() {
        view.applyGradient()
        emailACLTextField.displayView(id: 1, placeholder: "SIGN_IN_EMAIL_FIELD_PLACEHOLDER".localized, isCounterHidden: true, textFieldType: .Email())
        passwordACLTextField.displayView(id: 2, placeholder: "SIGN_IN_PASSWORD_FIELD_PLACEHOLDER".localized, rightIcon: ImageManager.shared.eyeClosed, rightIconSelected: ImageManager.shared.eye, isCounterHidden: true, keyboardType: .Default, textFieldType: .Password(minCharacters: GlobalConstants.minPasswordCharacters))
        signUpLabel
            .attributedText = "SIGN_IN_SIGN_IN_HERE_TEXT".localized
            .addAttributeText(text: signUpText, color: ColorManager.shared.red, font: .body1Bold, isUnderline: true)
    }
    
    private func addGesturesToLabels() {
        signUpLabel.addTapGesture(self, action: #selector(signUpLabelTapped(_:)))
    }
    
    private func bind() {
        viewModel.sessionEmail.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            self?.emailACLTextField.setTextValue(text: _result)
            self?.emailACLTextField.state = .Filled
        }
        
        viewModel.loading.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            if (_result) {
                ProgressFacade.showProgress()
            } else {
                ProgressFacade.hideProgress()
            }
        }
        
        viewModel.logInError.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            switch _result {
            case .emptyEmail:
                self?.emailACLTextField.hasError = true
                self?.emailACLTextField.setHelperTextValue(text: "SIGN_IN_EMAIL_FIELD_EMPTY".localized)
                break
            case .invalidEmail:
                self?.emailACLTextField.hasError = true
                self?.emailACLTextField.setHelperTextValue(text: "SIGN_IN_EMAIL_FIELD_INCORRECT_FORMAT".localized)
                break
            case .emptyPassword:
                self?.passwordACLTextField.hasError = true
                self?.passwordACLTextField.setHelperTextValue(text: "SIGN_IN_PASSWORD_FIELD_EMPTY".localized)
                break
            case .invalidPassword:
                self?.passwordACLTextField.hasError = true
                self?.passwordACLTextField.setHelperTextValue(text: "SIGN_IN_PASSWORD_FIELD_EMPTY".localized)
                break
            }
        }
        
        viewModel.isValidEmail.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            if (_result) {
                self?.emailACLTextField.cleanError()
            }
        }
        
        viewModel.isValidPassword.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            if (_result) {
                self?.passwordACLTextField.cleanError()
            }
        }
        
        viewModel.goToRegister.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            if (_result) {
                self?.coordinator?.goToSignUp()
            }
        }
        
        viewModel.logInSuccess.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            if (_result) {
                self?.coordinator?.goToEarthquakesView()
            }
        }
        
        viewModel.popUpError.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            self?.showErrorPopUp(viewData: _result)
        }
    }
    
    private func validateForm() {
        let notEmpty = !emailACLTextField.getTextValue().isEmpty && !passwordACLTextField.getTextValue().isEmpty
        let notErrors = !emailACLTextField.hasError && !passwordACLTextField.hasError
        if (notEmpty && notErrors) {
            DispatchQueue.main.async {
                self.viewModel.logIn(
                    LogInParam(
                        email: self.emailACLTextField.getTextValue(),
                        password: self.passwordACLTextField.getTextValue()
                    )
                )
            }
        }
    }
    
    @objc func signUpLabelTapped(_ gesture: UITapGestureRecognizer) {
        guard let text = signUpLabel.text else { return }
        let conditionsRange = (text as NSString).range(of: signUpText)
        if gesture.didTapAttributedTextInLabel(label: signUpLabel, inRange: conditionsRange) {
            coordinator?.goToSignUp()
        }
    }
    
    @IBAction func signInACLButtonTapped(_ sender: Any) {
        viewModel.validateEmail(emailACLTextField.getTextValue())
        viewModel.validatePassword(passwordACLTextField.getTextValue())
        validateForm()
    }
}
