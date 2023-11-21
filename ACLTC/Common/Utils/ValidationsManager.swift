//
//  ValidationsManager.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

public class ValidationsManager {
    
    public static let shared: ValidationsManager = ValidationsManager()
    
    private init() { }

    public static func isAtLimit(existingText: String?, newText: String, limit: Int = 4) -> Bool {
        let text = existingText ?? ""
        return text.count + newText.count <= limit
    }
    
    public static func isLessThan(_ text: String, limit: Int = 4) -> Bool {
        return text.count < limit
    }
}
