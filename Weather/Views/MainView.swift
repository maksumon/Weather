//
//  MainView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 11/01/2022.
//

import SwiftUI
import SwiftUIRefresh

struct MainView: View {
    @State private var showMenu = false
    @State private var isPullToRefresh = false
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    List {
                        if (viewModel.weather != nil) {
                            Section(header: Text("Today").font(.system(size: 14, weight: .bold, design: .default))) {
                                CurrentWeatherConditionView(
                                    currentWeather: (viewModel.weather?.current)!,
                                    currentDay: (viewModel.weather?.forecast?.forecastday?.first?.day)!
                                )
                            }
                        }
                        if (viewModel.weather != nil) {
                            Section(header: Text("Hourly").font(.system(size: 14, weight: .bold, design: .default))) {
                                HourlyView(hours: (viewModel.weather?.forecast?.forecastday?.first?.hour)!)
                            }
                        }
                        if (viewModel.weather != nil) {
                            Section(header: HStack {
                                Text("Air Quality").font(.system(size: 14, weight: .bold, design: .default))
                                Spacer()
                                NavigationLink("Info", destination: AirQualityDetailsView())
                            }) {
                                AirQualitySummaryView(currentWeather: (viewModel.weather?.current)!)
                            }
                        }
                        if (viewModel.weather != nil) {
                            Section(header: Text("Forecasts").font(.system(size: 14, weight: .bold, design: .default))) {
                                ForecastsView(forecast: (viewModel.weather?.forecast)!)
                            }
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/1.5 : 0)
                    .disabled(self.showMenu ? true : false)
                    .pullToRefresh(isShowing: $isPullToRefresh) {
                        self.viewModel.fetchWeather()
                        self.isPullToRefresh = false
                    }
                    if self.showMenu {
                        LocationListView()
                            .frame(width: geometry.size.width/1.5)
                            .transition(.move(edge: .leading))
                    }
                    if viewModel.isLoading {
                        ProgressView()
                            .scaleEffect(1.5, anchor: .center)
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .frame(width: geometry.size.width)
                    }
                }
            }
            .navigationBarTitle(
                viewModel.weather != nil
                    ? (viewModel.weather?.location?.name)!
                    : "Weather")
            .navigationBarItems(
                leading: (
                    Button(
                        action: {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                        }
                    ) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                ),
                trailing: (
                    Button(
                        action: {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                        }
                    ) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                )
            )
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
