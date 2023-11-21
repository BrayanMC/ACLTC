//
//  NetworkManager.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import Alamofire

class NetworkManager: NetworkManagerProtocol {
    
    let timeout: TimeInterval = 60 // 1min
    let retryLimit = 1
    
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    private var notConnectedToInternetError: ErrorResponse = ErrorResponse(
        message: "POP_UP_SERVER_ERROR_DESCRIPTION".localized,
        debugMessage: nil,
        timestamp: nil,
        code: nil,
        httpStatus: nil
    )
    private var serverError: ErrorResponse = ErrorResponse(
        message: "POP_UP_NO_INTERNET_DESCRIPTION".localized,
        debugMessage: nil,
        timestamp: nil,
        code: nil,
        httpStatus: nil
    )
    
    func request<T: Decodable>(_ url: String,
                               method: HTTPMethod = .get,
                               parameters: Parameters? = nil,
                               encoding: ParameterEncoding = URLEncoding.default,
                               responseType: T.Type,
                               completion: @escaping (Result<T?, CustomError>) -> Void) {
        if (!NetworkMonitor.shared.isConnected) {
            completion(.failure(.notConnectedToInternet(notConnectedToInternetError)))
        }
        AF.request(url, method: method,
                   parameters: parameters,
                   encoding: encoding,
                   requestModifier: { $0.timeoutInterval = self.timeout })
        .validate(statusCode: 200..<300)
        .responseJSON(emptyResponseCodes: [200]) { response in
            debugPrint("response: ", response)
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.success(nil))
                    }
                } else {
                    completion(.success(nil))
                }
            case .failure(_):
                switch response.response?.statusCode {
                case 400:
                    completion(.failure(.badRequest(self.buildError(response.data))))
                case 403:
                    completion(.failure(.forbidden(self.buildError(response.data))))
                case 401:
                    completion(.failure(.unAuthorized(self.buildError(response.data))))
                case 404:
                    completion(.failure(.notFound(self.buildError(response.data))))
                case 406:
                    completion(.failure(.notAcceptable(self.buildError(response.data))))
                case 409:
                    completion(.failure(.conflict(self.buildError(response.data))))
                case 412:
                    completion(.failure(.preconditionFailed(self.buildError(response.data))))
                case 422:
                    completion(.failure(.unProcessable(self.buildError(response.data))))
                case 421, 423:
                    completion(.failure(.locked(self.buildError(response.data))))
                case 500:
                    completion(.failure(.serverError(self.serverError)))
                default:
                    completion(.failure(.serverError(self.serverError)))
                }
            }
        }
    }
    
    private func buildError(_ error: Data?) -> ErrorResponse? {
        if let data = error {
            do {
                let decodedData = try JSONDecoder().decode(ErrorResponse.self, from: data)
                return decodedData
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
