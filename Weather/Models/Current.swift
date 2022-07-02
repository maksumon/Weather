//
//  Current.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 11/01/2022.
//

import Foundation

struct Current: Codable {
    let lastUpdatedEpoch: Int?
    let lastUpdated: String?
    let tempC, tempF, isDay: Double?
    let condition: Condition?
    let windMph, windKph: Double?
    let windDegree: Double?
    let windDir: String?
    let precipIn: Double?
    let humidity, cloud, feelslikeC, feelslikeF: Double?
    let uv: Int?
    let airQuality: [String: Double]?

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case uv
        case airQuality = "air_quality"
    }
}
