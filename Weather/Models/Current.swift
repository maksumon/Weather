//
//  Current.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 11/01/2022.
//

import Foundation

struct Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC, tempF, isDay: Int
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: String
    let precipIn: Double
    let humidity, cloud, feelslikeC, feelslikeF: Int
    let uv: Int
    let airQuality: [String: Double]

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch
        case lastUpdated
        case tempC
        case tempF
        case isDay
        case condition
        case windMph
        case windKph
        case windDegree
        case windDir
        case precipIn
        case humidity, cloud
        case feelslikeC
        case feelslikeF
        case uv
        case airQuality
    }
}
