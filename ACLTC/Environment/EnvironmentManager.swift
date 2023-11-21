//
//  EnvironmentManager.swift
//  ACLTC
//
//  Created by USUARIO on 21/11/23.
//

class EnvironmentManager {

    static let shared = EnvironmentManager()
    var current: Environment = .dev
    
    var baseURL: String {
        switch current {
        case .dev:
            return "https://earthquake.usgs.gov"
        case .qa:
            return "https://earthquake.usgs.gov"
        case .prod:
            return "https://earthquake.usgs.gov"
        }
    }
    
    private init() {}
}

enum Environment {
    case dev
    case qa
    case prod
}
