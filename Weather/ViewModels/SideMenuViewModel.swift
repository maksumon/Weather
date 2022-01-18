//
//  SideMenuViewModel.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 18/01/2022.
//

import Foundation

class SideMenuViewModel : ObservableObject {
    @Published var cities: [City]?
    @Published var isLoading = false
    @Published var isCityRemoved = false
    
    init() {
        getCities()
    }
    
    func getCities() {
        self.isLoading = true
        self.cities = DBHelper.shared.fetchCities()
        self.isLoading = false
    }
    
    func removeCity(city: City) {
        self.isLoading = true
        if DBHelper.shared.deleteCity(city: city) {
            isCityRemoved = ((self.cities?.removeAll(where: { item in
                item.name == city.name
            })) != nil)
        }
        self.isLoading = false
    }
}
