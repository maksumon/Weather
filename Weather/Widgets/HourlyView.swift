//
//  HourlyView.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 12/01/2022.
//

import SwiftUI
import NetworkImage

struct HourlyView: View {
    private let hours: [Hour]    
    
    init(hours: [Hour]) {
        self.hours = hours
    }
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(0..<self.hours.count) { i in
                    VStack(spacing: 5) {
                        NetworkImage(url: URL(string: "https:\((self.hours[i].condition?.icon)!)"))
                          .scaledToFit()
                          .frame(width: 44, height: 44, alignment: .center)
                        Text("\(self.hours[i].tempC!, specifier: "%.f")°")
                          .font(.system(size: 14, weight: .bold, design: .default))
                        Text(self.hours[i].time!.formatTime())
                          .font(.system(size: 14))
                    }
                    .padding(8)
                }
            }
        }
        .frame(height: 105)
    }
}
