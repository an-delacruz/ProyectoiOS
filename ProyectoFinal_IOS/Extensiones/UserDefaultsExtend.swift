//
//  UserDefaultsExtend.swift
//  ProyectoFinal_IOS
//
//  Created by user217901 on 5/30/22.
//

import Foundation

extension UserDefaults {
  func setCustomObject<T: Codable>(_ data: T?, forKey defaultName: String) {
    let encoded = try? JSONEncoder().encode(data)
    set(encoded, forKey: defaultName)
  }
    
    func getCustomObject<T : Codable>(dataType: T.Type, key: String) -> T? {
       guard let userDefaultData = data(forKey: key) else {
         return nil
       }
       return try? JSONDecoder().decode(T.self, from: userDefaultData)
     }
}
