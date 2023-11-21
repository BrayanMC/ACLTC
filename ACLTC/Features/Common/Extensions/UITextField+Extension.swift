//
//  UITextField+Extension.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

extension UITextField {
    
    public func setLeftView(_ view: UIView, padding: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = true
        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(view)
        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: view.frame.size.width + padding,
                height: view.frame.size.height + padding
            )
        )
        view.center = CGPoint(
            x: (outerView.bounds.size.width / 2) + padding,
            y: outerView.bounds.size.height / 2
        )
        self.leftView = outerView
    }
    
    public func setLeftView(_ view: UIView, paddingLeft: CGFloat, paddingRight: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = true
        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(view)
        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: view.frame.size.width + (paddingLeft + paddingRight),
                height: view.frame.size.height + paddingLeft
            )
        )
        view.center = CGPoint(
            x: (outerView.bounds.size.width / 2) + (paddingLeft - paddingRight),
            y: outerView.bounds.size.height / 2
        )
        leftView = outerView
        leftViewMode = .always
    }
    
    public func setRightView(_ view: UIView, padding: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = true
        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(view)
        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: view.frame.size.width + padding,
                height: view.frame.size.height + padding
            )
        )
        view.center = CGPoint(
            x: (outerView.bounds.size.width / 2) - padding,
            y: outerView.bounds.size.height / 2
        )
        rightView = outerView
    }
    
    public func setRightView(_ view: UIView, paddingRight: CGFloat, paddingLeft: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = true
        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(view)
        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: view.frame.size.width + (paddingRight + paddingLeft),
                height: view.frame.size.height + paddingRight
            )
        )
        view.center = CGPoint(
            x: (outerView.bounds.size.width / 2) - (paddingRight - paddingLeft),
            y: outerView.bounds.size.height / 2
        )
        rightView = outerView
    }
    
    public func setPadding(left: CGFloat, right: CGFloat? = nil) {
        setLeftPadding(left)
        if let rightPadding = right {
            setRightPadding(rightPadding)
        }
    }

    private func setLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }

    private func setRightPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
