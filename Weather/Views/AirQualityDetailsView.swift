//
//  AirQualityDetailsView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 13/01/2022.
//

import SwiftUI

struct AirQualityDetailsView: View {
    @ObservedObject var viewModel = AirQualityDetailsViewModel()
    private let twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            List {
                if (viewModel.airQualities != nil) {
                    ForEach(0..<viewModel.airQualities!.count, id: \.self) { i in
                        Section {
                            AirQualityDetailsItemView(airQuality: viewModel.airQualities![i])
                        }
                    }
                }
            }
            .navigationBarTitle("Air Quality Details")
        }
    }
}

struct AirQualityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityDetailsView()
    }
}
