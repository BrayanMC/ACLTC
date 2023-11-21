//
//  Protocols.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

// MARK: - NibLoadableView

protocol NibLoadableView: AnyObject { }

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }
}

extension UIView: NibLoadableView { }

// MARK: - ReusableView

protocol ReusableView: AnyObject { }

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView { }
