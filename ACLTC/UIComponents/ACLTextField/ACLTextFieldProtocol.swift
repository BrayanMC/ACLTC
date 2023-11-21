//
//  ACLTextFieldProtocol.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

public protocol ACLTextFieldActionProtocol: AnyObject {
    func textFieldTapped(id: Int)
}

public protocol ACLTextFieldEventsProtocol: AnyObject {
    func editingDidBegin(id: Int, _ text: String)
    func editingDidEnd(id: Int, _ text: String)
    func editingChanged(id: Int, _ text: String)
}

