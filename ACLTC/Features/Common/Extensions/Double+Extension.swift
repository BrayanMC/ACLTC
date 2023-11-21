//
//  Double+Extension.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

extension Double {
    
    public func formatWithTwoDecimals() -> String {
        String(format: "%.2f", self)
    }
    
    public func formatWithThreeDecimals() -> String {
        String(format: "%.3f", self)
    }
}

