//
//  Weather.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 11/01/2022.
//

import Foundation

struct Weather: Codable {
    let location: Location?
    let current: Current?
    let forecast: Forecast?
}
