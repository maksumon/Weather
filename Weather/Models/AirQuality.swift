//
//  AirQuality.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 13/01/2022.
//

import Foundation
import GRDB

struct AirQuality: Codable, FetchableRecord, PersistableRecord {
    let id: Int64
    let range: String
    let title: String
    let detail: String
}
