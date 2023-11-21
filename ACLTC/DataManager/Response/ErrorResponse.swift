//
//  ErrorResponse.swift
//  ACLTC
//
//  Created by USUARIO on 20/11/23.
//

struct ErrorResponse: Codable {
    let message: String?
    let debugMessage: String?
    let timestamp, code, httpStatus: String?
}
