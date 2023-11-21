//
//  ACLPopUpImageType.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

public enum ACLPopUpImageType {
    case alert
    
    func getImage() -> UIImage {
        switch self {
        case .alert:
            return ImageManager.shared.icACLPopUpAlert
        }
    }
}

