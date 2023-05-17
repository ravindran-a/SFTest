//
//  UserManager.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

class UserManager: ObservableObject {
    
    static let shared: UserManager = UserManager()
    var user: LoginResponseModel?
    @Published var loggedIn: Bool = UserDefaultsManager.boolForKey(.userLoggedIn)
    
    func logoutUser() {
        DispatchQueue.main.async {
            KeychainManager().removeAccess()
            UserDefaultsManager.removeAllUserDefaultValues()
            UserManager.shared.loggedIn = false
        }
    }
    
}
