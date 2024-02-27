//
//  CurrentTemperatureConditionView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 12/01/2022.
//

import SwiftUI
import NetworkImage

struct CurrentWeatherConditionView: View {
    private let currentWeather: Current
    private let currentDay: Day
    private let threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init(currentWeather: Current, currentDay: Day) {
        self.currentWeather = currentWeather
        self.currentDay = currentDay
    }
    
    var body: some View {
        VStack (spacing: 20) {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(currentWeather.tempC!, specifier: "%.f")°")
                        .font(.system(size: 45))
                    Text((currentWeather.condition?.text)!)
                        .font(.system(size: 16))
                }
                Spacer()
                NetworkImage(url: URL(string: "https:\((currentWeather.condition?.icon)!)"))
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            }
            LazyVGrid(columns: threeColumnGrid, spacing: 10) {
                VStack(alignment: .center) {
                    Text("\(currentWeather.humidity!, specifier: "%.f")%")
                        .font(.system(size: 16, weight: .bold, design: .default))
                    Text("Humidity")
                        .font(.system(size: 14))
                }
                VStack(alignment: .center) {
                    Text("\(currentWeather.uv!)")
                        .font(.system(size: 16, weight: .bold, design: .default))
                    Text("UV Index")
                        .font(.system(size: 14))
                }
                VStack(alignment: .center) {
                    Text("\(currentWeather.windDir!) \(currentWeather.windKph!, specifier: "%.1f") km/h")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                    Text("Wind")
                        .font(.system(size: 14))
                }
                VStack(alignment: .center) {
                    Text("\(currentWeather.feelslikeC!, specifier: "%.f")°")
                        .font(.system(size: 16, weight: .bold, design: .default))
                    Text("Feels Like")
                        .font(.system(size: 14))
                }
                VStack(alignment: .center) {
                    Text("\(currentDay.dailyChanceOfRain!)%")
                        .font(.system(size: 16, weight: .bold, design: .default))
                    Text("Chance of Rain")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                }
                VStack(alignment: .center) {
                    Text("\(currentDay.maxtempC!, specifier: "%.f")°/\(currentDay.mintempC!, specifier: "%.f")°")
                        .font(.system(size: 16, weight: .bold, design: .default))
                    Text("High/Low")
                        .font(.system(size: 14))
                }
            }
            .padding(8)
        }
    }
}
