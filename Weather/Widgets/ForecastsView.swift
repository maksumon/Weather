//
//  ForecastsView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 12/01/2022.
//

import SwiftUI

struct ForecastsView: View {
    private let forecast: Forecast
    
    init(forecast: Forecast) {
        self.forecast = forecast
    }
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(1..<self.forecast.forecastday!.count, id: \.self) { i in
                ForecastView(forecastDay: self.forecast.forecastday![i])
                if (i == 1) {
                    Divider()
                }
            }
        }
    }
}
