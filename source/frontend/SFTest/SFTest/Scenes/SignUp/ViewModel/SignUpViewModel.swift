//
//  SignUpViewModel.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    var alertMessage: String = ""
    
}
