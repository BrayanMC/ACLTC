//
//  NSMutableString+Extension.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import UIKit

extension NSMutableString {
    
    func rangeAll(of searchString: String, options mask: NSString.CompareOptions = []) -> [NSRange] {
        var ranges: [NSRange] = []
        var range = NSRange(location: 0, length: length)
        while (range.location != NSNotFound) {
            range = self.range(of: searchString, options: mask, range: range)
            if(range.location != NSNotFound) {
                ranges.append(range)
                let location = range.location + range.length
                range = NSRange(location: location, length: length - location)
            }
        }
        return ranges
    }
}
