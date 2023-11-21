//
//  NetworkManagerProtocol.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import Alamofire

protocol NetworkManagerProtocol: AnyObject {
    
    func request<T: Decodable>(_ url: String,
                               method: HTTPMethod,
                               parameters: Parameters?,
                               encoding: ParameterEncoding,
                               responseType: T.Type,
                               completion: @escaping (Result<T?, CustomError>) -> Void)
}

