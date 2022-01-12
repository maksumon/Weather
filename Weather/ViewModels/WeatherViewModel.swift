//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 12/01/2022.
//

import Foundation

class WeatherViewModel : ObservableObject {
    @Published var weather: Weather?
    private let apiHelper = APIHelper()
    
    func fetchWeather() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API.BASE_URL
        urlComponents.path = "\(API.API_VERSION)\(API.FORCAST_ENDPOINT)"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: Constants.WEATHER_API_KEY),
            URLQueryItem(name: "q", value: "Dhaka"),
            URLQueryItem(name: "days", value: "3"),
            URLQueryItem(name: "aqi", value: "yes"),
            URLQueryItem(name: "alerts", value: "no")
        ]

        apiHelper.request(fromURL: urlComponents.url!) { (result: Result<Weather, Error>) in
            switch result {
            case .success(let weather):
                debugPrint("We got a successful result with: \(weather)")
                self.weather = weather
            case .failure(let error):
                debugPrint("We got a failure trying to get the weather. The error we got was: \(error.localizedDescription)")
            }
         }
    }
}
