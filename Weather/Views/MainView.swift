//
//  MainView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 11/01/2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if (viewModel.weather != nil) {
                    Section {
                        CurrentWeatherConditionView(
                            currentWeather: (viewModel.weather?.current)!,
                            currentDay: (viewModel.weather?.forecast?.forecastday?.first?.day)!
                        )
                    }
                }
                if (viewModel.weather != nil) {
                    Section(header: Text("Today").font(.system(size: 14, weight: .bold, design: .default))) {
                        HourlyView(hours: (viewModel.weather?.forecast?.forecastday?.first?.hour)!)
                    }
                }
                if (viewModel.weather != nil) {
                    Section(header: Text("Air Quality").font(.system(size: 14, weight: .bold, design: .default))) {
                        AirQualitySummaryView(currentWeather: (viewModel.weather?.current)!)
                    }
                }
                if (viewModel.weather != nil) {
                    Section(header: Text("Forecasts").font(.system(size: 14, weight: .bold, design: .default))) {
                        ForecastsView(forecast: (viewModel.weather?.forecast)!)
                    }
                }
            }
            .navigationBarTitle(
                viewModel.weather != nil
                    ? (viewModel.weather?.location?.name)!
                    : "Weather"
            )
            .listStyle(.insetGrouped)
            .onAppear {
                self.viewModel.fetchWeather()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
