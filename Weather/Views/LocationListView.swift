//
//  LocationListView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 13/01/2022.
//

import SwiftUI

struct LocationListView: View {
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("Weather Around")
                    .foregroundColor(.gray)
                    .font(.system(size: 20, weight: .bold, design: .default))
                Text("Messages")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .padding(.top, 30)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Weather Around", displayMode: .inline)
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
