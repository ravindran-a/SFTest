//
//  LoginViewModel.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    var alertMessage: String = ""
    let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func loginApiEvent(userId: String, password: String) async {
        isLoading = true
        do {
            if let response: (Data, URLResponse) = try await authService.userLogin(userId: userId, password: password) {
                let model: LoginResponseModel = try JSONDecoder().decode(LoginResponseModel.self, from: response.0)
                KeychainManager.shared.setAccess(jwtToken: model.token)
                UserDefaultsManager.setBool(true, forKey: .userLoggedIn)
            }
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.alertMessage = "\(error.localizedDescription)"
        }
    }
    
}
