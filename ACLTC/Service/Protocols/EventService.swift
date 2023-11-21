//
//  EventService.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

protocol EventService: AnyObject {
    func getEarthquakes(_ params: GetEarthquakeParam, completion: @escaping (Result<Earthquake?, CustomError>) -> Void)
}

