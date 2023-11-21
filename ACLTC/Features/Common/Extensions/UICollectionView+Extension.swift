//
//  UICollectionView+Extension.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

extension UICollectionReusableView {
    
    public static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionView {
    
    public func register<T: UICollectionViewCell>(cell: T.Type) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    public func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
        return cell
    }
}
