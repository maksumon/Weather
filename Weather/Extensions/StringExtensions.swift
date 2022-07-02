//
//  StringExtensions.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 12/01/2022.
//

import Foundation

extension String {
    func formatTime() -> String {
        var formattedTime = self
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"

        let dateFormatterReturn = DateFormatter()
        dateFormatterReturn.dateFormat = "hh:mm a"

        if let date = dateFormatterGet.date(from: self) {
            formattedTime = dateFormatterReturn.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        
        return formattedTime
    }
    
    func formatDate() -> String {
        var formattedTime = self
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterReturn = DateFormatter()
        dateFormatterReturn.dateFormat = "MMMM dd, yyyy"

        if let date = dateFormatterGet.date(from: self) {
            formattedTime = dateFormatterReturn.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        
        return formattedTime
    }
}
