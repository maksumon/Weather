//
//  AirQualitySummaryView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 12/01/2022.
//

import SwiftUI

struct AirQualitySummaryView: View {
    private let currentWeather: Current
    
    init(currentWeather: Current) {
        self.currentWeather = currentWeather
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Text("\((currentWeather.airQuality?["pm2_5"])!, specifier: "%.2f")")
                .font(.system(size: 45))
            Text("|  PM2.5  |")
                .font(.system(size: 16))
            Text(Constants.airQualityDefinition[Int((currentWeather.airQuality?["us-epa-index"])!)]!)
                .font(.system(size: 16))
        }
    }
}
