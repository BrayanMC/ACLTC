//
//  EventRepositoryImpl.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import Alamofire

class EventRepositoryImpl: EventRepository {
    
    func getEarthquakes(_ params: GetEarthquakeParam, completion: @escaping (Result<Earthquake?, CustomError>) -> Void) {
        NetworkManager.shared.request(
            Endpoint.getEarthquakes(startTime: params.startTime, endTime: params.endTime).url.absoluteString,
            method: .get,
            encoding: JSONEncoding.default,
            responseType: EarthquakeResponse.self
        ) { result in
            switch result {
            case .success(let response):
                let result: Earthquake? = response?.toDomain()
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

