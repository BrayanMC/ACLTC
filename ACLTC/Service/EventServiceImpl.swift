//
//  EventServiceImpl.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

class EventServiceImpl: EventService {
    
    var repository: EventRepository = EventRepositoryImpl()
    
    func getEarthquakes(_ params: GetEarthquakeParam, completion: @escaping (Result<Earthquake?, CustomError>) -> Void) {
        repository.getEarthquakes(params) { result in
            completion(result)
        }
    }
}
