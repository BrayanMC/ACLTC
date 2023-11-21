//
//  ACLTextField.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

public class ACLTextField: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var helperTextLabel: UILabel!
    @IBOutlet weak var characterCounterLabel: UILabel!
    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var textFieldButton: UIButton!
    
    private var isValid: Bool = false
    private var performInlineValidation: Bool = false
    private var id: Int = 0
    private let tooltipHeightAndWidth = 24
    private let tooltipPadding: CGFloat = 8
    private let padding: CGFloat = 16.0
    private var datePicker: UIDatePicker? = nil
    private var timer: Timer?
    
    internal var isEmojiAllowed: Bool = false
    public var maxOfCharacters: Int = 0
    public var minOfCharacters: Int = 0
    internal var documentTypeSelected: Int = DocumentTypeLocalIds.None
    internal var textFieldType: ACLTextFieldType = .Default
    internal var keyboardType: ACLKeyboardType = .Default
    
    private weak var actionDelegate: ACLTextFieldActionProtocol?
    private weak var eventsDelegate: ACLTextFieldEventsProtocol?
    
    public var state: ACLTextFieldState = .Enabled {
        didSet {
            setStyle()
        }
    }
    
    public var hasError: Bool = false {
        didSet {
            if (hasError) {
                state = .Error
            } else {
                state = textField.text!.isEmpty ? .Enabled : .Filled
            }
        }
    }
    
    public var isEnabled: Bool = true {
       didSet {
           textField.isEnabled = isEnabled
           textFieldButton.isEnabled = isEnabled
           if (state != .Loading) {
               state = textField.text!.isEmpty ? (isEnabled ? .Enabled : .Disabled) : .Filled
           }
       }
    }
    
    public var isReadOnly: Bool = true {
        didSet {
            textField.isEnabled = !isReadOnly
            textFieldButton.isHidden = !isReadOnly
            state = .Enabled
        }
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed(ACLTextField.nibName, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
    
    public func displayView(
        id: Int = 0,
        actionDelegate: ACLTextFieldActionProtocol? = nil,
        eventsDelegate: ACLTextFieldEventsProtocol? = nil,
        text: String = "",
        placeholder: String = "",
        leftIcon: UIImage? = nil,
        rightIcon: UIImage? = nil,
        rightIconSelected: UIImage? = nil,
        isEnabled: Bool = true,
        isHidden: Bool = false,
        isEmojiAllowed: Bool = false,
        isCounterHidden: Bool = false,
        performInlineValidation: Bool = false,
        keyboardType: ACLKeyboardType = .Default,
        textFieldType: ACLTextFieldType = .Default
    ) {
        addBarButtonToKeyboard()
        self.id = id
        self.textField.delegate = self
        self.actionDelegate = actionDelegate
        self.eventsDelegate = eventsDelegate
        textField.placeholder = placeholder
        self.performInlineValidation = performInlineValidation
        self.isEnabled = isEnabled
        self.isHidden = isHidden
        self.textFieldType = textFieldType
        self.keyboardType = keyboardType
        self.isEmojiAllowed = isEmojiAllowed
        characterCounterLabel.isHidden = isCounterHidden
        textField.setPadding(left: padding, right: padding)
        switch (self.textFieldType) {
        case .Business(let maxCharacters):
            maxOfCharacters = maxCharacters
            applySettingsForBusinessField()
            break
        case .Email:
            applySettingsForEmailField()
            break
        case .Password(let minCharacters, _):
            minOfCharacters = minCharacters
            applySettingsForPasswordField(leftIcon, rightIcon, rightIconSelected)
            break
        case .Name:
            applySettingsForNameField()
            break
        case .LastName:
            applySettingsForLastNameField()
            break
        case .DocumentNumber(let documentType):
            applySettingsForDocumentNumberField(documentType)
            break
        case .CellPhoneNumber:
            applySettingsForCellPhoneNumberField()
            break
        case .OTP:
            applySettingsForOTP()
            break
        case .CardNumber:
            applySettingsForCardNumberField(rightIcon, rightIconSelected)
            break
        case .CVVCode:
            applySettingsForCVVCodeField(rightIcon, rightIconSelected)
            break
        case .Account(let maxCharacters):
            maxOfCharacters = maxCharacters
            applySettingsForAccountField()
            break
        case .Date:
            applySettingsForDateField()
            break
        case .Search:
            applySettingsForSearchField()
            break
        case .Default:
            applySettingsForDefault(leftIcon)
            break
        }
        characterCounterLabel.text = String(format: "CHARACTER_COUNTER_TEXT".localized, "ZERO_TEXTO".localized, String(maxOfCharacters))
    }
    
    private func applySettingsForBusinessField() {
        self.textField.keyboardType = .numberPad
        self.textField.autocorrectionType = .no
    }
    
    private func applySettingsForEmailField() {
        self.textField.keyboardType = .emailAddress
        self.textField.autocorrectionType = .no
    }
    
    private func applySettingsForPasswordField(_ leftIcon: UIImage?, _ rightIcon: UIImage?, _ rightIconSelected: UIImage?) {
        self.textField.isSecureTextEntry = true
        switch keyboardType {
        case .Numeric:
            self.textField.keyboardType = .numberPad
        case .Alphanumeric:
            self.textField.keyboardType = .namePhonePad
        default:
            break
        }
        
        if (leftIcon != nil) {
            let iv = UIImageView(image: leftIcon)
            iv.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(tooltipHeightAndWidth), height: CGFloat(tooltipHeightAndWidth))
            self.textField.setLeftView(iv, padding: tooltipPadding)
            self.textField.leftViewMode = .always
        }
        
        if (rightIcon != nil) {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(tooltipHeightAndWidth), height: CGFloat(tooltipHeightAndWidth))
            btn.setImage(rightIcon, for: .normal)
            if (rightIconSelected != nil) {
                btn.setImage(rightIconSelected, for: .selected)
            }
            btn.addTarget(self, action: #selector(self.passwordRightIconTap), for: .touchUpInside)
            self.textField.setRightView(btn, padding: tooltipPadding)
            self.textField.rightViewMode = .always
        }
    }
    
    private func applySettingsForNameField() {
        self.textField.autocapitalizationType = .words
    }
    
    private func applySettingsForLastNameField() {
        self.textField.autocapitalizationType = .words
    }
    
    private func applySettingsForDocumentNumberField(_ documentType: Int) {
        switch (documentType) {
        case DocumentTypeLocalIds.DNI:
            self.textField.keyboardType = .numberPad
            break
        default:
            break
        }
    }
    
    private func applySettingsForCellPhoneNumberField() {
        self.textField.keyboardType = .numberPad
    }
    
    private func applySettingsForOTP() {
        switch keyboardType {
        case .Default, .Numeric:
            self.textField.keyboardType = .numberPad
        case .Alphanumeric:
            self.textField.keyboardType = .namePhonePad
        }
        
        if #available(iOS 12.0, *) {
            self.textField.textContentType = .oneTimeCode
        }
        
        self.textField.autocapitalizationType = .allCharacters
        self.textField.autocorrectionType = .no
        self.textField.returnKeyType = .done
    }
    
    private func applySettingsForCardNumberField(_ rightIcon: UIImage?, _ rightIconSelected: UIImage?) {
        self.textField.isSecureTextEntry = true
        switch keyboardType {
        case .Default, .Numeric:
            self.textField.keyboardType = .numberPad
        case .Alphanumeric:
            self.textField.keyboardType = .namePhonePad
        }
        
        if (rightIcon != nil) {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(tooltipHeightAndWidth), height: CGFloat(tooltipHeightAndWidth))
            btn.setImage(rightIcon, for: .normal)
            if (rightIconSelected != nil) {
                btn.setImage(rightIconSelected, for: .selected)
            }
            btn.addTarget(self, action: #selector(self.passwordRightIconTap), for: .touchUpInside)
            self.textField.setRightView(btn, padding: tooltipPadding)
            self.textField.rightViewMode = .always
        }
    }
    
    private func applySettingsForCVVCodeField(_ rightIcon: UIImage?, _ rightIconSelected: UIImage?) {
        self.textField.isSecureTextEntry = true
        switch keyboardType {
        case .Default, .Numeric:
            self.textField.keyboardType = .numberPad
        case .Alphanumeric:
            self.textField.keyboardType = .namePhonePad
        }
        
        if (rightIcon != nil) {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(tooltipHeightAndWidth), height: CGFloat(tooltipHeightAndWidth))
            btn.setImage(rightIcon, for: .normal)
            
            if (rightIconSelected != nil) {
                btn.setImage(rightIconSelected, for: .selected)
            }
            btn.addTarget(self, action: #selector(self.passwordRightIconTap), for: .touchUpInside)
            self.textField.setRightView(btn, padding: tooltipPadding)
            self.textField.rightViewMode = .always
        }
    }
    
    private func applySettingsForAccountField() {
        self.textField.keyboardType = .numberPad
        self.textField.autocorrectionType = .no
    }
    
    private func applySettingsForDateField() {
        self.setUpDatePicker()
    }
    
    private func applySettingsForSearchField() {}
    
    private func applySettingsForDefault(_ leftIcon: UIImage?) {
        if (leftIcon != nil) {
            let iv = UIImageView(image: leftIcon)
            iv.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(tooltipHeightAndWidth), height: CGFloat(tooltipHeightAndWidth))
            self.textField.setLeftView(iv, padding: tooltipPadding)
            self.textField.leftViewMode = .always
        }
    }
    
    private func dissmisKeyboard() {
        endEditing(true)
    }
    
    public func showKeyboard() {
        textField.becomeFirstResponder()
    }
    
    public func clear() {
        reset()
    }
    
    private func reset() {
        setTextValue(text: .empty)
        switch self.textFieldType {
        case .Business:
            characterCounterLabel.text = String(format: "CHARACTER_COUNTER_TEXT".localized, "ZERO_TEXTO".localized, String(maxOfCharacters))
            break
        case .Account:
            characterCounterLabel.text = String(format: "CHARACTER_COUNTER_TEXT".localized, "ZERO_TEXTO".localized, String(maxOfCharacters))
            break
        default:
            break
        }
        self.layoutIfNeeded()
    }

    private func getValid() -> Bool {
        return self.isValid
    }
    
    public func setCenterInputTextStyle() {
        self.textField.textAlignment = .center
    }
    
    public func getTextValue() -> String  {
        return self.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    public func setTextValue(text: String) {
        self.textField.text = text
    }
    
    public func setHelperTextValue(text: String) {
        helperTextLabel.isHidden = text.isEmpty
        helperTextLabel.text = text
    }
    
    public func setTextColorValue(color: UIColor) {
        self.setTextColor(color: color)
    }
    
    public func getTextFieldType() -> ACLTextFieldType {
        return self.textFieldType
    }
    
    public func getDocumentTypeSelected() -> Int {
        return self.documentTypeSelected
    }
    
    public func setDocumentTypeSelected(id: Int) {
        self.setTextValue(text: "")
        self.documentTypeSelected = id
        self.changeKeyBoardType()
    }
    
    private func changeKeyBoardType() {
        switch (self.documentTypeSelected) {
        case DocumentTypeLocalIds.DNI:
            self.textField.keyboardType = .numberPad
            break
        default:
            break
        }
    }
    
    public func setPlaceholderColor(color: UIColor) {
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }
    
    public func setBorderColor(color: UIColor) {
        textField.layer.borderColor = color.cgColor
    }

    public func setTextColor(color: UIColor) {
        textField.textColor = color
    }

    public func setHelperTextColor(color: UIColor) {
        helperTextLabel.textColor = color
    }
    
    public func cleanError() {
        self.setHelperTextValue(text: "")
        self.hasError = false
    }
    
    public func disable() {
        dissmisKeyboard()
        isEnabled = false
    }
    
    public func enable() {
        isEnabled = true
    }
    
    public func getId() -> Int {
        return self.id
    }
    
    public func getState() -> ACLTextFieldState {
        state
    }
    
    // MARK: - State
    
    private func setStyle() {
        switch state {
        case .Enabled:
            setPlaceholderColor(color: ColorManager.shared.black300)
            setTextColor(color: ColorManager.shared.black300)
            setBorderColor(color: ColorManager.shared.black300)
            break
        case .Disabled:
            setPlaceholderColor(color: ColorManager.shared.black200)
            setTextColor(color: ColorManager.shared.black200)
            setBorderColor(color: ColorManager.shared.black200)
            break
        case .Focused:
            setPlaceholderColor(color: ColorManager.shared.black300)
            setTextColor(color: ColorManager.shared.black400)
            setBorderColor(color: ColorManager.shared.primary700)
            break
        case .Error:
            setPlaceholderColor(color: ColorManager.shared.black300)
            setTextColor(color: ColorManager.shared.black400)
            setBorderColor(color: ColorManager.shared.red)
            setHelperTextColor(color: ColorManager.shared.red)
            break
        case .Filled:
            setPlaceholderColor(color: ColorManager.shared.black300)
            setTextColor(color: ColorManager.shared.black400)
            setBorderColor(color: ColorManager.shared.black400)
            break
        case .Loading:
            setPlaceholderColor(color: ColorManager.shared.black300)
            setTextColor(color: ColorManager.shared.black400)
            setBorderColor(color: ColorManager.shared.primary700)
            break
        }
    }
    
    // MARK: - Date field
    
    private func setUpDatePicker() {
        let currentDate = Date()
        let dateComponent = DateComponents()
        let maximumDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.maximumDate = maximumDate
        if #available(iOS 13.4, *) {
            datePicker!.preferredDatePickerStyle = .wheels
        }
        datePicker?.sizeToFit()
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "BAR_BUTTON_ACCEPT_TEXT".localized, style: UIBarButtonItem.Style.plain, target: self, action: #selector(datePickerAcceptButtonTapped))
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputView = datePicker
        textField.inputAccessoryView = toolBar
    }
    
    public func openPicker() {
        if datePicker != nil {
            textField.becomeFirstResponder()
        }
    }
    
    public func getSelectedDate() -> Date {
        datePicker?.date ?? Date()
    }
    
    public func setMinimumDate(_ date: Date) {
        if let _datePicker = datePicker {
            let dateComponent = DateComponents()
            let minimumDate = Calendar.current.date(byAdding: dateComponent, to: date)
            _datePicker.minimumDate = minimumDate
        }
    }
    
    @objc func datePickerAcceptButtonTapped() {
        if let _datePicker = datePicker {
            textField.text = UtilsManager.formatDateToString(date: _datePicker.date, toFormat: DateFormats.dd_MM_yyyy)
            endEditing(true)
        }
    }
    
    // MARK: - keyboard bar button
    
    private func addBarButtonToKeyboard() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "BAR_BUTTON_ACCEPT_TEXT".localized, style: UIBarButtonItem.Style.plain, target: self, action: #selector(textFieldAcceptButtonTapped))
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func textFieldAcceptButtonTapped() {
        dissmisKeyboard()
    }
    
    // MARK: - Validation State
    
    public func showProgressIndicator() {
        state = .Loading
        disable()
        startTimer()
        indicatorImageView.isHidden = false
    }
    
    public func hideProgressIndicator() {
        state = .Enabled
        enable()
        stopTimer()
        indicatorImageView.isHidden = true
    }
    
    private func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func animateView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveLinear, animations: {
            self.indicatorImageView.transform = self.indicatorImageView.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
    
    // MARK: - @IBAction actions
    
    @IBAction func aclTextFieldEditingChanged(_ textField: UITextField) {
        switch self.textFieldType {
        case .Account:
            guard let text = textField.text else { return }
            let newText = text.removeWhitespaceAndDashes()
            characterCounterLabel.text = String(format: "CHARACTER_COUNTER_TEXT".localized, String(newText.count), String(maxOfCharacters))
            eventsDelegate?.editingChanged(id: getId(), newText)
            break
        case .Business:
            guard let text = textField.text else { return }
            characterCounterLabel.text = String(format: "CHARACTER_COUNTER_TEXT".localized, String(text.count), String(maxOfCharacters))
            eventsDelegate?.editingChanged(id: getId(), text)
            break
        case .Email:
            guard let text = textField.text else { return }
            eventsDelegate?.editingChanged(id: getId(), text)
            break
        case .Password:
            guard let text = textField.text else { return }
            eventsDelegate?.editingChanged(id: getId(), text)
            break
        case .Search:
            guard let text = textField.text else { return }
            eventsDelegate?.editingChanged(id: getId(), text)
            break
        case .Date:
            guard let text = textField.text else { return }
            eventsDelegate?.editingChanged(id: getId(), text)
            break
        case .OTP, .Name, .LastName, .DocumentNumber, .CellPhoneNumber, .CardNumber, .CVVCode, .Default:
            break
        }
    }
    
    @IBAction func aclTextFieldEditingDidBegin(_ textField: UITextField) {
        if let text = textField.text {
            if (!hasError) {
                state = .Focused
            }
            eventsDelegate?.editingDidBegin(id: getId(), text)
        }
    }
    
    @IBAction func aclTextFieldEditingDidEnd(_ textField: UITextField) {
        if let text = textField.text {
            if (!hasError && text.count != 0) {
                state = .Filled
            }
            eventsDelegate?.editingDidEnd(id: getId(), text)
        }
    }
    
    @IBAction func textFieldButtonTapped(_ sender: Any) {
        if (isReadOnly) {
            actionDelegate?.textFieldTapped(id: getId())
        }
    }
    
    // MARK: - @objc properties
    
    @objc func passwordRightIconTap(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.textField.isSecureTextEntry = !sender.isSelected
    }
}
