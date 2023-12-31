//
//  EarthquakeResponse.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import Foundation

// MARK: - EarthquakeResponse
struct EarthquakeResponse: MapperProtocol {
    let type: String?
    let metadata: Metadata?
    let features: [Feature]?
    
    // MARK: - Feature
    struct Feature: MapperProtocol {
        let type: String?
        let properties: Properties?
        let geometry: Geometry?
        let id: String?
        
        // MARK: - Geometry
        struct Geometry: MapperProtocol {
            let type: String?
            let coordinates: [Double]?
        }

        // MARK: - Properties
        struct Properties: MapperProtocol {
            let mag: Double?
            let place: String?
            let url, detail: String?
            let status: String?
            let tsunami, sig, time: Int?
            let net, code, ids, sources: String?
            let types: String?
            let rms: Double?
            let magType, type, title: String?
        }
    }

    // MARK: - Metadata
    struct Metadata: MapperProtocol {
        let generated: Int?
        let url: String?
        let title: String?
        let status: Int?
        let api: String?
        let count: Int?
    }
}

