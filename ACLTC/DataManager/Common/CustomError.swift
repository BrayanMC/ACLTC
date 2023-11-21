//
//  CustomError.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import Foundation

enum CustomError: Error {
    case noData
    case unAuthorized(ErrorResponse?)
    case notFound(ErrorResponse?)
    case locked(ErrorResponse?)
    case unavailableServer(ErrorResponse?)
    case badRequest(ErrorResponse?)
    case conflict(ErrorResponse?)
    case forbidden(ErrorResponse?)
    case unProcessable(ErrorResponse?)
    case serverError(ErrorResponse?)
    case preconditionRequired(ErrorResponse?)
    case notConnectedToInternet(ErrorResponse?)
    case preconditionFailed(ErrorResponse?)
    case notAcceptable(ErrorResponse?)
}
