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

    func fetchCities() -> [City]? {
        do {
            let cities = try DBHelper.shared.dbQueue!.read { db in
                try City.fetchAll(db)
            }
            return cities
        } catch {
            debugPrint(error)
        }
        return nil
    }

    func insertCity(city: City) -> Bool {
        var success = false
        var existedCity: City?
        
        do {
            try DBHelper.shared.dbQueue!.read { db in
                existedCity = try City.filter(Column("name") == city.name && Column("country") == city.country).fetchOne(db)
            }
        } catch {
            debugPrint(error)
        }
        
        do {
            if existedCity == nil {
                try DBHelper.shared.dbQueue!.write { db in
                    if city.current == 1 {
                        try db.execute(
                                sql: "INSERT INTO city (name, country, latitude, longitude, current) VALUES (?, ?, ?, ?, ?)",
                                arguments: [city.name, city.country, city.latitude, city.longitude, city.current]
                        )
                    } else {
                        try db.execute(
                                sql: "INSERT INTO city (name, country, latitude, longitude) VALUES (?, ?, ?, ?)",
                                arguments: [city.name, city.country, city.latitude, city.longitude]
                        )
                    }
                    success = true
                }
            } else {
                debugPrint("\(city.name) already exists in DB")
                success = false
            }
        } catch {
            debugPrint(error)
        }
        
        return success
    }
    
    func deleteCity(city: City) -> Bool {
        var success = false
        
        do {
            try DBHelper.shared.dbQueue!.write { db in
                success = try City.deleteOne(db, key: city.id)
            }
        } catch {
            debugPrint(error)
        }
        
        return success
    }
}
