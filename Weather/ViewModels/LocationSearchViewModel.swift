//
//  LocationSearchViewModel.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 14/01/2022.
//

import Foundation
import SwiftLocation
import SwiftUI

class LocationSearchViewModel : ObservableObject {
    @Published var cities: [City] = []
    @Published var isLoading = false
    @Published var isCityAdded = false
    
    func searchLocation(query: String) {
        self.isLoading = true
        
        self.cities.removeAll()
        
        let service = Autocomplete.Google(partialMatches: query)
        service.APIKey = Constants.GOOGLE_PLACES_API_KEY

        SwiftLocation.autocompleteWith(service).then { result in
            // Extract the array of found `GeoLocation` places
            switch result {
            case .success(let data):
                debugPrint("Result: \(data)")
                
                data.forEach { place in
                    let detailService = Autocomplete.Google(
                        detailsFor: place.partialAddress,
                        APIKey: Constants.GOOGLE_PLACES_API_KEY
                    )
                    detailService?.placeTypes = [.cities]
                    
                    SwiftLocation.autocompleteWith(detailService!).then { detail in
                        switch detail {
                        case .success(let info):
                            let places = info.map({ $0.place })
                            if !places.isEmpty {
                                guard let firstResult: GeoLocation = places.first! else { return }
                                print(firstResult.coordinates)
                                print(firstResult.info[.formattedAddress]!!)
                                
                                guard let locality = firstResult.info[.locality] else { return }
                                
                                if locality != nil {
                                    let dictCity = [
                                        "name": locality!,
                                        "country": firstResult.info[.country]!!,
                                        "latitude": firstResult.coordinates.latitude,
                                        "longitude": firstResult.coordinates.longitude
                                    ] as [String : Any]
                                    
                                    do {
                                        let jsonCity = try JSONSerialization.data(withJSONObject: dictCity, options: .prettyPrinted)
                                        let city = try JSONDecoder().decode(City.self, from: Data(jsonCity))
                                        
                                        if self.cities.contains(where: { city in
                                            city.name == dictCity["name"] as! String
                                            && city.country == dictCity["country"] as! String })
                                        {
                                            print("\(String(describing: locality)) exists in the array")
                                        } else {
                                            self.cities.append(city)
                                        }
                                        
                                        self.isLoading = false
                                    } catch {
                                        debugPrint("City Decoding Error: \(error)")
                                        self.isLoading = false
                                    }
                                }
                            }
                        case .failure(let error):
                            debugPrint("Detail Service Error: \(error)")
                            self.isLoading = false
                        }
                    }
                }
                self.isLoading = false
            case .failure(let error):
                debugPrint("Service Error: \(error)")
                self.isLoading = false
            }
        }
    }
    
    func addCity(city: City) {
        self.isLoading = true
        isCityAdded = DBHelper.shared.insertCity(city: city)
        self.isLoading = false
    }
}
