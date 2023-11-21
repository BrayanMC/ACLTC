//
//  SignUpController.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import UIKit

class SignUpController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var emailACLTextField: ACLTextField!
    @IBOutlet weak var nameACLTextField: ACLTextField!
    @IBOutlet weak var lastNameACLTextField: ACLTextField!
    @IBOutlet weak var passwordACLTextField: ACLTextField!
    @IBOutlet weak var signInLabel: UILabel!
    
    private let signInText: String = "Inicia aquí"
    private lazy var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        addGesturesToLabels()
        bind()
        hideKeyboardWhenTappedAround()
    }
    
    private func initViews() {
        view.applyGradient()
        emailACLTextField.displayView(id: 1, placeholder: "SIGN_UP_EMAIL_FIELD_PLACEHOLDER".localized, isCounterHidden: true, textFieldType: .Email())
        nameACLTextField.displayView(id: 2, placeholder: "SIGN_UP_NAMES_FIELD_PLACEHOLDER".localized, isCounterHidden: true, textFieldType: .Name)
        lastNameACLTextField.displayView(id: 3, placeholder: "SIGN_UP_LAST_NAMES_FIELD_PLACEHOLDER".localized, isCounterHidden: true, textFieldType: .LastName)
        passwordACLTextField.displayView(id: 4, placeholder: "SIGN_UP_PASSWORD_FIELD_PLACEHOLDER".localized, rightIcon: ImageManager.shared.eyeClosed, rightIconSelected: ImageManager.shared.eye, isCounterHidden: true, keyboardType: .Default, textFieldType: .Password(minCharacters: GlobalConstants.minPasswordCharacters))
        signInLabel
            .attributedText = "SIGN_UP_SIGN_UP_HERE_TEXT".localized
            .addAttributeText(text: signInText, color: ColorManager.shared.red, font: .body1Bold, isUnderline: true)
    }
    
    private func addGesturesToLabels() {
        signInLabel.addTapGesture(self, action: #selector(signInLabelTapped(_:)))
    }
    
    private func bind() {
        viewModel.loading.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            if (_result) {
                ProgressFacade.showProgress()
            } else {
                ProgressFacade.hideProgress()
            }
        }
        
        viewModel.signUpError.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            switch _result {
            case .emptyEmail:
                self?.emailACLTextField.hasError = true
                self?.emailACLTextField.setHelperTextValue(text: "SIGN_UP_EMAIL_FIELD_EMPTY".localized)
                break
            case .invalidEmail:
                self?.emailACLTextField.hasError = true
                self?.emailACLTextField.setHelperTextValue(text: "SIGN_UP_EMAIL_FIELD_INCORRECT_FORMAT".localized)
                break
            case .emptyName:
                self?.nameACLTextField.hasError = true
                self?.nameACLTextField.setHelperTextValue(text: "SIGN_UP_NAME_FIELD_EMPTY".localized)
                break
            case .emptyLastName:
                self?.lastNameACLTextField.hasError = true
                self?.lastNameACLTextField.setHelperTextValue(text: "SIGN_UP_LAST_NAME_FIELD_EMPTY".localized)
                break
            case .emptyPassword:
                self?.passwordACLTextField.hasError = true
                self?.passwordACLTextField.setHelperTextValue(text: "SIGN_UP_PASSWORD_FIELD_EMPTY".localized)
                break
            case .invalidPassword:
                self?.passwordACLTextField.hasError = true
                self?.passwordACLTextField.setHelperTextValue(text: "SIGN_UP_PASSWORD_FIELD_EMPTY".localized)
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
        
        viewModel.isValidName.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            if (_result) {
                self?.nameACLTextField.cleanError()
            }
        }
        
        viewModel.isValidLastName.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            if (_result) {
                self?.lastNameACLTextField.cleanError()
            }
        }
        
        viewModel.isValidPassword.bind { [weak self] result in
            guard self != nil else { return }
            guard let _result = result else { return }
            if (_result) {
                self?.passwordACLTextField.cleanError()
            }
        }
        
        viewModel.signUpSuccess.bind { [weak self] result in
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
        let notEmpty = !emailACLTextField.getTextValue().isEmpty && !nameACLTextField.getTextValue().isEmpty && !lastNameACLTextField.getTextValue().isEmpty && !passwordACLTextField.getTextValue().isEmpty
        let notErrors = !emailACLTextField.hasError && !nameACLTextField.hasError && !lastNameACLTextField.hasError && !passwordACLTextField.hasError
        if (notEmpty && notErrors) {
            DispatchQueue.main.async {
                self.viewModel.register(
                    SignUpParam(
                        email: self.emailACLTextField.getTextValue(),
                        name: self.nameACLTextField.getTextValue(),
                        lastName: self.lastNameACLTextField.getTextValue(),
                        password: self.passwordACLTextField.getTextValue()
                    )
                )
            }
        }
    }
    
    @objc func signInLabelTapped(_ gesture: UITapGestureRecognizer) {
        guard let text = signInLabel.text else { return }
        let conditionsRange = (text as NSString).range(of: signInText)
        if gesture.didTapAttributedTextInLabel(label: signInLabel, inRange: conditionsRange) {
            coordinator?.goToSignInView()
        }
    }
    
    @IBAction func signUpACLButtonTapped(_ sender: Any) {
        viewModel.validateEmail(emailACLTextField.getTextValue())
        viewModel.validateName(nameACLTextField.getTextValue())
        viewModel.validateLastName(lastNameACLTextField.getTextValue())
        viewModel.validatePassword(passwordACLTextField.getTextValue())
        validateForm()
    }
}
