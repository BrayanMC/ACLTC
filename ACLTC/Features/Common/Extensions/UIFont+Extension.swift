//
//  UIFont+Extension.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

extension UIFont {
    
    enum LineHeight {
        case h1, h2, h3, h4
        case st1, st2, body1, body2, caption1
        
        var value: CGFloat {
            switch self {
            case .h1: return 32
            case .h2: return 28
            case .h3: return 24
            case .h4: return 20
            case .st1: return 24
            case .st2: return 22
            case .body1: return 20
            case .body2: return 18
            case .caption1: return 16
            }
        }
    }
    
    enum Size {
        case h1, h2, h3, h4
        case st1, st2, body1, body2, caption1
        
        var value: CGFloat {
            switch self {
            case .h1: return 28
            case .h2: return 24
            case .h3: return 20
            case .h4: return 16
            case .st1: return 20
            case .st2: return 18
            case .body1: return 16
            case .body2: return 14
            case .caption1: return 12
            }
        }
    }
    
    static var body1Regular: UIFont {
        return UIFont(name: NunitoFont.Regular.rawValue, size: Size.body1.value) ?? UIFont()
    }
    
    static var body1Bold: UIFont {
        return UIFont(name: NunitoFont.Bold.rawValue, size: Size.body1.value) ?? UIFont()
    }
    
    static var body2Regular: UIFont {
        return UIFont(name: NunitoFont.Regular.rawValue, size: Size.body2.value) ?? UIFont()
    }
    
    static var body2Bold: UIFont {
        return UIFont(name: NunitoFont.Bold.rawValue, size: Size.body2.value) ?? UIFont()
    }
    
    static var caption1Regular: UIFont {
        return UIFont(name: NunitoFont.Regular.rawValue, size: Size.caption1.value) ?? UIFont()
    }
    
    static var caption1Bold: UIFont {
        return UIFont(name: NunitoFont.Bold.rawValue, size: Size.caption1.value) ?? UIFont()
    }
}
