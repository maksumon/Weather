//
//  DBHelper.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 13/01/2022.
//

import Foundation
import GRDB

class DBHelper {
    static let shared = DBHelper()
    var dbQueue: DatabaseQueue? = nil

    private init() {
        guard self.dbQueue == nil else { return }
        dbQueue = getDBInstance()
    }
    
    func getDBInstance() -> DatabaseQueue? {
        do {
            let fileManager = FileManager.default
            let dbPath = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("weather.db")
                .path
            if !fileManager.fileExists(atPath: dbPath) {
                let dbResourcePath = Bundle.main.path(forResource: "weather", ofType: "db")!
                try fileManager.copyItem(atPath: dbResourcePath, toPath: dbPath)
            }
            return try DatabaseQueue(path: dbPath)
        } catch {
            debugPrint(error)
        }
        return nil
    }
    
    func fetchAirQualityDetails() -> [AirQuality]? {
        do {
            let airQualities = try DBHelper.shared.dbQueue!.read { db in
                try AirQuality.fetchAll(db, sql: "SELECT * FROM air_quality_detail")
            }
            return airQualities;
        } catch {
            debugPrint(error)
        }
        return nil
    }
}
