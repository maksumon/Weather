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
                    }
                }
            }.listStyle(.plain)
        }
        .navigationTitle("Search Location")
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
