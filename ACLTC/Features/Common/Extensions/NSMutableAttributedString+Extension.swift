//
//  NSMutableAttributedString+Extension.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

extension NSMutableAttributedString {
    
    public func addAttributeText(textFind: String? = nil, color: UIColor? = nil, font: UIFont? = nil, isUnderline: Bool = false, all: Bool = true) -> NSMutableAttributedString {
        if let _textFind = textFind {
            if _textFind != .empty {
                if all {
                    self.mutableString.rangeAll(of: _textFind).forEach({
                        self.addAttributeText(range: $0, color: color, font: font, isUnderline: isUnderline)
                    })
                } else {
                    let range = self.mutableString.range(of: _textFind)
                    self.addAttributeText(range: range, color: color, font: font, isUnderline: isUnderline)
                }
            }
        } else {
            let range = self.mutableString.range(of: self.string)
            self.addAttributeText(range: range, color: color, font: font, isUnderline: isUnderline)
        }
        return self
    }
    
    private func addAttributeText(range: NSRange, color: UIColor? = nil, font: UIFont? = nil, isUnderline: Bool = false) {
        if let color = color {
            self.addAttribute(.foregroundColor, value: color, range: range)
        }
        
        if let font = font {
            self.addAttribute(.font, value: font, range: range)
        }
        
        if isUnderline {
            self.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        }
    }
    
    public func addMultipleTextAttributes(textsToFind: [String] = [], color: UIColor? = nil, font: UIFont? = nil, isUnderline: Bool = false, all: Bool = true) -> NSMutableAttributedString {
        if (!textsToFind.isEmpty) {
            textsToFind.forEach { textFind in
                if textFind != .empty {
                    if all {
                        self.mutableString.rangeAll(of: textFind).forEach({
                            self.addAttributeText(range: $0, color: color, font: font, isUnderline: isUnderline)
                        })
                    } else {
                        let range = self.mutableString.range(of: textFind)
                        self.addAttributeText(range: range, color: color, font: font, isUnderline: isUnderline)
                    }
                }
            }
        }
        return self
    }
}
