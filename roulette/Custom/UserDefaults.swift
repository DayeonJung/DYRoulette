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
  case winnerID
  case candidateList
}


@propertyWrapper
struct CodableUserDefault<T: Codable> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            guard let data = userDefaults.data(forKey: key) else {
                return defaultValue
            }
            do {
                let value = try PropertyListDecoder().decode(T.self, from: data)
                return value
            } catch {
                print("\(error.localizedDescription)")
                return defaultValue
            }
        }
        set {
            do {
                let data = try PropertyListEncoder().encode(newValue)
                userDefaults.set(data, forKey: key)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}
