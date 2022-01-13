//
//  City.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 14/01/2022.
//

import Foundation

struct City: Codable {
    let id: Int64?
    var name, country: String
    var latitude, longitude: Double
    let current: Int?
}
