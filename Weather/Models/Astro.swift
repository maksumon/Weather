//
//  Astro.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 11/01/2022.
//

import Foundation

struct Astro: Codable {
    let sunrise, sunset, moonPhase: String?
    let moonIllumination: Int64?

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }
}
