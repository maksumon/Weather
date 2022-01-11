//
//  Hour.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 11/01/2022.
//

import Foundation

struct Hour: Codable {
    let timeEpoch: Int
    let time: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: Condition
    let precipMm, precipIn: Double
    let humidity, willItRain, chanceOfRain, willItSnow: Int
    let chanceOfSnow, uv: Int

    enum CodingKeys: String, CodingKey {
        case timeEpoch
        case time
        case tempC
        case tempF
        case isDay
        case condition
        case precipMm
        case precipIn
        case humidity
        case willItRain
        case chanceOfRain
        case willItSnow
        case chanceOfSnow
        case uv
    }
}
