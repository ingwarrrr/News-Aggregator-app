//
//  UserDefaultsManager.swift
//  News Aggregator
//
//  Created by Igor on 29.06.2023.
//

import UIKit

class UserDefaultsManager
{
    // MARK:- Properties
    
    public static var shared = UserDefaultsManager()
    
    var newsArray: [UniqueNewsModel] {
        get {
            guard let data = UserDefaults.standard
                .data(forKey: StringConstants.userDefaultsNewsKey)
            else {
                return []
            }
            return (try? JSONDecoder()
                .decode([UniqueNewsModel].self, from: data)) ?? []
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                return
            }
            UserDefaults.standard
                .set(data, forKey: StringConstants.userDefaultsNewsKey)
        }
    }
    
    var newsImageArray: [UIImage?] {
        get {
            guard let data = UserDefaults.standard
                .data(forKey: StringConstants.userDefaultsNewsImageKey)
            else {
                return []
            }
            let decoded = (try? JSONDecoder().decode([Data].self, from: data)) ?? []
            
            return decoded.map { data in UIImage(data: data) }
        }
        set {
            let data = newValue.map { image in
                image?.jpegData(compressionQuality: 0)
            }
            let encoded =  try? JSONEncoder().encode(data)
            UserDefaults.standard
                .set(encoded, forKey: StringConstants.userDefaultsNewsImageKey)
        }
    }
    
    // MARK:- Init
    
    private init(){}
}
