//
//  NetworkManager.swift
//  Eckero Line
//
//  Created by Triet Le on 27.4.2020.
//  Copyright © 2020 Rederiaktiebolaget Eckero. All rights reserved.
//

import Foundation
import Combine

public final class NetworkManager {

    // MARK: - Private properties
    private let baseUrlString: String
    private let decoder: JSONDecoder

    // MARK: - Init
    init(baseUrlString: String, decoder: JSONDecoder) {
        self.baseUrlString = baseUrlString
        self.decoder = decoder
    }

    // MARK: - Public methods
    func getWeatherFor(locationId: Int) -> AnyPublisher<Weather?, Error> {
        if let request = createURLRequest(from: WeatherAPI.weather(locationId: locationId)) {
            return run(request)
        }

        return Just(nil).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    // MARK: - Private methods
    private func run<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> T in
                return try self.decoder.decode(T.self, from: result.data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func createURLRequest(from requestType: APIRequestProtocol) -> URLRequest? {
        let urlString = baseUrlString + requestType.path

        guard let url = URL(string: urlString) else {
            return nil
        }

        var request = URLRequest(url: url, timeoutInterval: 60)
        request.httpMethod = requestType.method.rawValue

        if let parameters = requestType.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }

        if let headers = requestType.headers {
            request.allHTTPHeaderFields = headers
        }

        return request
    }
    
}
