//
//  AuthService.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

class AuthService: AuthServiceProtocol {
    func userLogin(userId: String, password: String) async throws -> (Data, URLResponse)? {
        let url: String = APIEndPoints.Account.login.url
        return try await APIManager.shared.request(serviceURL: url, httpMethod: .post, parameters: ["username": userId, "password": password], tokenEnabled: false)
    }
    
    func userSignUp(userId: String, password: String) async throws -> (Data, URLResponse)? {
        let url: String = APIEndPoints.Account.signUp.url
        return try await APIManager.shared.request(serviceURL: url, httpMethod: .post, parameters: ["username": userId, "password": password], tokenEnabled: false)
    }
}
    
