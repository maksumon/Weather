//
//  ForecastView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 12/01/2022.
//

import SwiftUI

struct ForecastView: View {
    private let forecastDay: Forecastday
    private let twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(forecastDay: Forecastday) {
        self.forecastDay = forecastDay
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text((forecastDay.date)!.formatDate())
                .font(.system(size: 16, weight: .bold, design: .default))
            LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                VStack(alignment: .center) {
                    Text("\((forecastDay.day?.avghumidity)!)%")
                        .font(.system(size: 16, weight: .bold, design: .default))
                    Text("Humidity")
                        .font(.system(size: 14))
                }
                VStack(alignment: .center) {
                    Text("\((forecastDay.day?.uv)!)")
                        .font(.system(size: 16, weight: .bold, design: .default))
                    Text("UV Index")
                        .font(.system(size: 14))
                }
                VStack(alignment: .center) {
                    Text("\((forecastDay.day?.dailyChanceOfRain)!)%")
                        .font(.system(size: 16, weight: .bold, design: .default))
                    Text("Chance of Rain")
                        .font(.system(size: 14))
                }
                VStack(alignment: .center) {
                    Text("\((forecastDay.day?.maxtempC)!, specifier: "%.f")°/\((forecastDay.day?.mintempC)!, specifier: "%.f")°")
                        .font(.system(size: 16, weight: .bold, design: .default))
                    Text("High/Low")
                        .font(.system(size: 14))
                }
            }.padding(8)
            HourlyView(hours: (forecastDay.hour)!)
        }.padding(8)
    }
}
