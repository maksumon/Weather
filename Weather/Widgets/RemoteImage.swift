//
//  RemoteImage.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 27/02/2024.
//

import Foundation
import SwiftUI

struct RemoteImage: View {
    private let url: URL
    @State private var imageData: Data?
    @State private var isLoading = true
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        if let imageData = imageData, let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .aspectRatio(contentMode: .fit)
        } else {
            ProgressView()
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image from URL: \(url)")
                return
            }
            DispatchQueue.main.async {
                self.imageData = data
                self.isLoading = false
            }
        }.resume()
    }
}
