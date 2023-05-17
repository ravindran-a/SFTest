//
//  UserDefaultsManager.swift
//  LoremPicsum
//
//  Created by Ravindran on 17/05/23.
//

import Foundation
import UIKit

enum UserDefaultsManager {
    
    enum UserDefaultsKeyType: String {
        case favourites = "com.SFTest.favourites"
        case userLoggedIn = "com.SFTest.userLoggedIn"
    }
    
    static func setInt(_ int: Int?, forKey key: UserDefaultsKeyType, synchronize: Bool = true) {
                
        guard let confirmedInt = int else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.set(confirmedInt, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    static func setString(_ string: String?, forKey key: UserDefaultsKeyType, synchronize: Bool = true) {
                
        guard let confirmedString = string else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.set(confirmedString, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    static func setObject(_ object: Any?, forKey key: UserDefaultsKeyType, synchronize: Bool = true) {
                
        guard let confirmedObject = object else {
            UserDefaultsManager.removeValueForKey(key, synchronize: synchronize)
            return
        }
        
        UserDefaults.standard.set(confirmedObject, forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
    }

    static func setBool(_ bool: Bool, forKey key: UserDefaultsKeyType, synchronize: Bool = true) {

        UserDefaults.standard.set(bool, forKey: key.rawValue)

        if synchronize {
            UserDefaults.standard.synchronize()
        }

    }

    static func removeValueForKey(_ key: UserDefaultsKeyType, synchronize: Bool = true) {
                
        UserDefaults.standard.set("", forKey: key.rawValue)
        
        if synchronize {
            UserDefaults.standard.synchronize()
        }
        
    }
    
    static func removeAllUserDefaultValues() {
        UserDefaultsManager.removeValueForKey(.favourites)
    }
    
    static func stringForKey(_ key: UserDefaultsKeyType) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    static func integerForKey(_ key: UserDefaultsKeyType) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    static func objectForKey(_ key: UserDefaultsKeyType) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue) as Any?
    }

    static func boolForKey(_ key: UserDefaultsKeyType) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }

}
