//
//  ACLPopUpAction.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

public struct ACLPopUpAction {
    
    public let title: String
    public let type: ACLPopUpButtonType
    public let handler: (() -> Void)?
    
    public init(title: String, type: ACLPopUpButtonType, handler: (() -> Void)?) {
        self.title = title
        self.type = type
        self.handler = handler
    }
}

