//
//  AirQualityDetailsViewModel.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 13/01/2022.
//

import Foundation

class AirQualityDetailsViewModel : ObservableObject {
    @Published var airQualities: [AirQuality]?
    
    func fetchAirQualities() {
        self.airQualities = DBHelper.shared.fetchAirQualityDetails()
    }
}
