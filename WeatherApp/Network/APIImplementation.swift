//
//  APIImplementation.swift
//  Eckero Line
//
//  Created by Triet Le on 16.10.2020.
//

import Foundation

extension WeatherAPI {
    var path: String {
        switch self {
        case let .weather(locationId):
            return "/api/location/\(locationId)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .weather:
            return .get
        }
    }
    
    var headers: ReaquestHeaders? {
        nil
    }
    
    var parameters: RequestParameters? {
        nil
    }
}
