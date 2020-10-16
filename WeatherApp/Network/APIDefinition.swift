//
//  APIDefinition.swift
//  Eckero Line
//
//  Created by Triet Le on 16.10.2020.
//

import Foundation

typealias ReaquestHeaders = [String: String]
typealias RequestParameters = [String : Any?]
typealias Closure<T> = (T) -> Void

protocol APIRequestProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var headers: ReaquestHeaders? { get }
    var parameters: RequestParameters? { get }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error, Equatable {
    case noData
    case challenge
    case invalidResponse
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case unknown
}

public enum WeatherAPI: APIRequestProtocol {
    case weather(locationId: Int)
}
