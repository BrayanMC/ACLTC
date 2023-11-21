//
//  Mapper+Response.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

import Foundation

protocol MapperProtocol: Codable {
}

extension MapperProtocol {
    
    func toDomain<U: Codable>() -> U? {
        do {
            let data = try JSONEncoder().encode(self)
            return try JSONDecoder().decode(U.self, from: data)
        } catch {
            print("conversion error: \(error)")
            return nil
        }
    }
}
