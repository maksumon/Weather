//
//  LocationSearchView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 13/01/2022.
//

import SwiftUI
import SwiftLocation

struct LocationSearchView: View {
    @State private var text: String = ""
    @ObservedObject var viewModel = LocationSearchViewModel()
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            VStack {
                HStack {
                    TextField(
                        "Search Location Here",
                        text: $text,
                        onCommit: {
                            if !self.text.isEmpty {
                                viewModel.searchLocation(query: self.text)
                            }
                        }
                    ).textFieldStyle(.roundedBorder)
                    if !self.text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply.circle")
                        }
                    }
                }.padding()
                Spacer()
                List {
                    if (viewModel.cities.count > 0) {
                        ForEach(0..<viewModel.cities.count, id: \.self) { i in
                            Text("\(viewModel.cities[i].name), \(viewModel.cities[i].country)")
                                .onTapGesture {
                                    viewModel.addCity(city: viewModel.cities[i])
                                }.alert(isPresented: $viewModel.isCityAdded) {
                                    Alert(
                                        title: Text("Success"),
                                        message: Text("City Added Successfully")
                                    )
                                }
                        }
                    }
                }.listStyle(.plain)
            }
        }
        .navigationTitle("Search Location")
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
