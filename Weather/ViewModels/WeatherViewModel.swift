//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 12/01/2022.
//

import Foundation
import SwiftLocation

class WeatherViewModel : ObservableObject {
    @Published var weather: Weather?
    @Published var isLoading = false
    @Published var currentCity = ""
    
    private let apiHelper = APIHelper()
    
    init() {
        getCurrentLocationAndFetchWeather()
    }
    
    func getCurrentLocationAndFetchWeather() {
        let cities = DBHelper.shared.fetchCities()
        
        for city in cities! {
            if city.current != 0 {
                self.currentCity = city.name
                self.fetchWeather(city: self.currentCity)
                break
            }
        }
        
        if cities!.isEmpty && self.currentCity.isEmpty {
            SwiftLocation.gpsLocation().then {
                debugPrint("Location is \(String(describing: $0.location))")
                let service = Geocoder.Apple(
                    lat: ($0.location?.coordinate.latitude)!,
                    lng: ($0.location?.coordinate.longitude)!
                )
                SwiftLocation.geocodeWith(service).then { result in
                    // Different services, same expected output [GeoLocation]
                    switch result {
                    case .success(let data):
                        let firstResult: GeoLocation = data.first!
                        print(firstResult.coordinates)
                        print(firstResult.info[.formattedAddress]!!)
                        
                        guard let locality = firstResult.info[.locality] else { return }
                        
                        if locality != nil {
                            let dictCity = [
                                "name": locality!,
                                "country": firstResult.info[.country]!!,
                                "latitude": firstResult.coordinates.latitude,
                                "longitude": firstResult.coordinates.longitude,
                                "current": 1
                            ] as [String : Any]
                            
                            do {
                                let jsonCity = try JSONSerialization.data(withJSONObject: dictCity, options: .prettyPrinted)
                                let city = try JSONDecoder().decode(City.self, from: Data(jsonCity))
                                
                                debugPrint("Current location: \(city)")
                                
                                if DBHelper.shared.insertCity(city: city) {
                                    self.currentCity = city.name
                                    self.fetchWeather(city: self.currentCity)
                                }
                            } catch {
                                debugPrint("City Decoding Error: \(error)")
                            }
                        }
                    case .failure(let error):
                        debugPrint("Reverse geocode error: \(error)")
                    }
                }
            }
        }
    }
    
    func fetchWeather(city: String) {
        self.isLoading = true
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API.BASE_URL
        urlComponents.path = "\(API.API_VERSION)\(API.FORCAST_ENDPOINT)"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: Constants.WEATHER_API_KEY),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "days", value: "3"),
            URLQueryItem(name: "aqi", value: "yes"),
            URLQueryItem(name: "alerts", value: "no")
        ]
        
        debugPrint("Weather API URL: \(String(describing: urlComponents.url))")
        
        apiHelper.request(fromURL: urlComponents.url!) { (result: Result<Weather, Error>) in
            switch result {
            case .success(let weather):
                debugPrint("We got a successful result with: \(weather)")
                self.weather = weather
                self.isLoading = false
            case .failure(let error):
                debugPrint("We got a failure trying to get the weather. The error we got was: \(error.localizedDescription)")
                self.isLoading = false
            }
         }
    }
}
