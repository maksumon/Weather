//
//  AirQualityDetailsViewModel.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 13/01/2022.
//

import Foundation

class AirQualityDetailsViewModel : ObservableObject {
    @Published var isLoading = false
    @Published var airQualities: [AirQuality]?
    
    init() {
        fetchAirQualities()
    }
    
    func fetchAirQualities() {
        self.isLoading = true
        self.airQualities = DBHelper.shared.fetchAirQualityDetails()
        self.isLoading = false
    }
}
