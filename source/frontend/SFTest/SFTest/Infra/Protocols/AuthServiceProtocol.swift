//
//  AuthServiceProtocol.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

protocol AuthServiceProtocol {
    func userLogin(userId: String, password: String) async throws -> (Data, URLResponse)?
    func userSignUp(userId: String, password: String) async throws -> (Data, URLResponse)?
}
