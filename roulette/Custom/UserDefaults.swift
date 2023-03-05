//
//  UserDefaults.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/05.
//

import Foundation

let userDefaults = UserDefaults.standard

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}

enum UserDefaultKeys: String {
  case rouletteItems
}
