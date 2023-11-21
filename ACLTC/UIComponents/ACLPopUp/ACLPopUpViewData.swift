//
//  ACLPopUpViewData.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

public struct ACLPopUpViewData {
    
    public let title: String
    public let description: String
    public let boldHighlighting: Bool
    public let boldTexts: [String]
    public let popUpType: ACLPopUpType
    public let actions: [ACLPopUpAction]
    
    public init(title: String, description: String, popUpType: ACLPopUpType, actions: [ACLPopUpAction]) {
        self.title = title
        self.description = description
        self.popUpType = popUpType
        self.actions = actions
        self.boldHighlighting = false
        self.boldTexts = []
    }
    
    public init(title: String, description: String, boldHighlighting: Bool = false, boldTexts: [String] = [], popUpType: ACLPopUpType, actions: [ACLPopUpAction]) {
        self.title = title
        self.description = description
        self.popUpType = popUpType
        self.actions = actions
        self.boldHighlighting = boldHighlighting
        self.boldTexts = boldTexts
    }
}
