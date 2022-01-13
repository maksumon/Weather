//
//  AirQualityDetailsItemView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 13/01/2022.
//

import SwiftUI

struct AirQualityDetailsItemView: View {
    private let airQuality: AirQuality
    
    init(airQuality: AirQuality) {
        self.airQuality = airQuality
    }
    
    var body: some View {
        VStack {
            Text("\(self.airQuality.range): \(self.airQuality.title)")
                .font(.system(size: 16, weight: .bold, design: .default))
            Divider()
            Text(self.airQuality.detail)
                .fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 16))
        }
    }
}
