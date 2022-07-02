//
//  Hour.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 11/01/2022.
//

import Foundation

struct Hour: Codable {
    let timeEpoch: Int?
    let time: String?
    let tempC, tempF: Double?
    let isDay: Int?
    let condition: Condition?
    let precipMm, precipIn: Double?
    let humidity, willItRain, chanceOfRain, willItSnow: Int?
    let chanceOfSnow, uv: Int?

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case uv
    }
}
