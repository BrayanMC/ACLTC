//
//  UILabel+Extension.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

extension UILabel {
    
    public func setLineHeight(_ lineHeight: CGFloat, lineHeightMultiple: CGFloat? = nil, kern: CGFloat? = nil) {
        if let text = self.text {
            let style = NSMutableParagraphStyle()
            if (lineHeightMultiple != nil) {
                style.lineHeightMultiple = lineHeightMultiple!
            }
            let attributeString: NSMutableAttributedString
            if (kern != nil) {
                attributeString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: kern!, NSAttributedString.Key.paragraphStyle: style])
            } else {
                attributeString = NSMutableAttributedString(string: text)
            }
            let range = NSString(string: text).range(of: text)
            style.lineSpacing = lineHeight - self.font.lineHeight
            style.alignment = self.textAlignment
            attributeString.addAttribute(.paragraphStyle, value: style, range: range)
            self.attributedText = attributeString
        }
    }
}
