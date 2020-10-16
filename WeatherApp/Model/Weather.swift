//
//  Weather.swift
//  WeatherApp
//
//  Created by Triet Le on 16.10.2020.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let consolidatedWeather: [ConsolidatedWeather]
    let timezoneName: String?
    let title, locationType: String?
    let woeid: Int?
    let lattLong, timezone: String?
}

// MARK: - ConsolidatedWeather
struct ConsolidatedWeather: Codable {
    let id: Int
    let applicableDate: Date
    let minTemp, maxTemp, theTemp, windSpeed: Double
}
