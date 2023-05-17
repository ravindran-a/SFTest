//
//  KeychainManager.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation
import KeychainAccess

class KeychainManager {
    
    private let jwtKey: String = "com.sftest.jwt"
    
    static let shared: KeychainManager = KeychainManager()
    
    var manager: Keychain {
        return Keychain(service: "com.sftest.credentials")
    }
    
    var jwt: String? {
        return manager[jwtKey]
    }
    
    func updateAccess(jwtToken: String?) {
        guard let jwt = jwtToken else { return }
        manager[jwtKey] = jwt
    }
    
    func setAccess(jwtToken: String?) {
        guard let jwt = jwtToken else { return }
        manager[jwtKey] = jwt
    }
    
    func removeAccess() {
        manager[jwtKey] = nil
    }
    
}
