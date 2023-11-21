//
//  Endpoint.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

import Foundation

enum Endpoint {
    case getEarthquakes(startTime: String, endTime: String)
}

extension Endpoint {
    
    var url: URL {
        switch self {
        case .getEarthquakes(let startTime, let endTime):
            return .baseUrlV1("fdsnws/event", params: ["format": "geojson", "starttime": startTime, "endtime": endTime, "orderby": "time"])
        }
    }
}

private extension URL {
    
    static func baseUrlV1(_ endpoint: String, params: [String: String] = [:]) -> URL {
        buildURL(basePath: EnvironmentManager.shared.baseURL, version: "1", path: endpoint, params: params)
    }
    
    static func buildURL(basePath: String, version: String, path: String, params: [String: String]) -> URL {
        let fullPath = buildPath(path: path + "/" + version, params: params)
        return URL(string: basePath + "/" + fullPath)!
    }
    
    static func buildPath(path: String, params: [String: String]) -> String {
        let queryString = params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        return queryString.isEmpty ? path : "\(path)/query?\(queryString)"
    }
}
