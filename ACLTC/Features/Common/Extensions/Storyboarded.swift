//
//  Storyboarded.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(_ sb: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: sb, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
