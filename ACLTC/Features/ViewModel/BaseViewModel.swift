//
//  BaseViewModel.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

class BaseViewModel {
    var loading: Observable<Bool> = Observable(nil)
    var popUpError: Observable<ACLPopUpViewData> = Observable(nil)
    var error: Observable<ErrorResponse> = Observable(nil)
    
    public func buildErrorNotContemplatedPopUpViewData(completion: (() -> Void)?) -> ACLPopUpViewData {
        ACLPopUpViewData(
            title: "POP_UP_NOT_CONTEMPLATED_ERROR_TITLE".localized,
            description: "POP_UP_NOT_CONTEMPLATED_ERROR_DESCRIPTION".localized,
            popUpType: .error,
            actions: [ACLPopUpAction(
                title: "POP_UP_TRY_AGAIN_BUTTON_TITLE".localized,
                type: .primary,
                handler: {
                    completion?()
                }
            )]
        )
    }
    
    public func buildErrorPopUpViewData(title: String, description: String, type: ACLPopUpType = .error, buttonTitle: String, completion: (() -> Void)?) -> ACLPopUpViewData {
        buildErrorPopUpViewData(title: title, description: description, boldHighlighting: false, boldTexts: [], type: type, buttonTitle: buttonTitle, completion: completion)
    }
    
    public func buildErrorPopUpViewData(title: String, description: String, boldHighlighting: Bool, boldTexts: [String], type: ACLPopUpType = .error, buttonTitle: String, completion: (() -> Void)?) -> ACLPopUpViewData {
        ACLPopUpViewData(
            title: title,
            description: description,
            boldHighlighting: boldHighlighting,
            boldTexts: boldTexts,
            popUpType: type,
            actions: [ACLPopUpAction(
                title: buttonTitle,
                type: .primary,
                handler: {
                    completion?()
                }
            )]
        )
    }
}

