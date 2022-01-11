//
//  Day.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 11/01/2022.
//

import Foundation

struct Day: Codable {
    let maxtempC, maxtempF, mintempC, mintempF: Double
    let avgtempC, avgtempF, maxwindMph, maxwindKph: Double
    let totalprecipMm, totalprecipIn: Double
    let avghumidity, dailyWillItRain, dailyChanceOfRain, dailyWillItSnow: Int
    let dailyChanceOfSnow: Int
    let condition: Condition
    let uv: Int

    enum CodingKeys: String, CodingKey {
        case maxtempC
        case maxtempF
        case mintempC
        case mintempF
        case avgtempC
        case avgtempF
        case maxwindMph
        case maxwindKph
        case totalprecipMm
        case totalprecipIn
        case avghumidity
        case dailyWillItRain
        case dailyChanceOfRain
        case dailyWillItSnow
        case dailyChanceOfSnow
        case condition, uv
    }
}
