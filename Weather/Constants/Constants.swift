//
//  letants.swift
//  Weather
//
//  Created by Mohammad Ashraful Kabir on 12/01/2022.
//

import Foundation

struct Constants {
  static let BANNER_OFFSET = 50.0;
  static let WEATHER_API_KEY = "a1cc21f6d97e450c932162919211407"
  static let GOOGLE_PLACES_API_KEY = "AIzaSyBvDw0PDkfQzi73LJGQx1uB2bPa22-uepE"
  static let GOOGLE_PLACES_SEARCH_TYPES = "locality|sublocality"
  static let IOS_BANNER_AD_ID = "ca-app-pub-1481218635435666/7562532031"
  static let IOS_INTERSTITIAL_AD_ID = "ca-app-pub-1481218635435666/3623287021"
  static let ANDROID_BANNER_AD_ID = "ca-app-pub-1481218635435666/9865261746"
  static let ANDROID_INTERSTITIAL_AD_ID = "ca-app-pub-1481218635435666/3139716077"
  static let BANNER_TEST_AD_ID = "ca-app-pub-3940256099942544/6300978111"
  static let INTERSTITIAL_TEST_AD_ID = "ca-app-pub-3940256099942544/1033173712"

  static let airQualityDefinition = [
    1: "Good",
    2: "Fair",
    3: "Poor",
    4: "Unhealthy",
    5: "Very Unhealthy",
    6: "Hazardous"
  ];
}
