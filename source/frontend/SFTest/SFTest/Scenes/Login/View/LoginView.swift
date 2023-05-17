//
//  LoginView.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @State var userId: String = ""
    @State var password: String = ""
    @State var showUserValidationMessage: Bool = false
    @State var showPasswordValidationMessage: Bool = false
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel(authService: AuthService())
    @State var showSignUpScreen: Bool = false
    @EnvironmentObject var userManager: UserManager
    
    private var userIdValidated: Bool {
        !userId.isEmpty
    }
    
    private var passwordValidated: Bool {
        !password.isEmpty
    }
    
    var loginView: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 20) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFit()
                .foregroundColor(Color.accentColor)
            Text("Todo List")
                .foregroundColor(Color.accentColor)
            Spacer()
            TextField("User Id", text: $userId)
                .frame(maxWidth: 500.0)
                .textInputAutocapitalization(.never)
                .onChange(of: userId) { _ in
                    showUserValidationMessage = false
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(showUserValidationMessage ? Color.red : Color.gray,
                            lineWidth: 1))
            if showUserValidationMessage {
                if !userIdValidated {
                    Text("User Id cannot be empty")
                        .foregroundColor(.accentColor)
                }
            }
            SecureField("Password", text: $password)
                .frame(maxWidth: 500.0)
                .textInputAutocapitalization(.never)
                .onChange(of: password) { _ in
                    showPasswordValidationMessage = false
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(showPasswordValidationMessage ? Color.red : Color.gray,
                            lineWidth: 1))
            if showPasswordValidationMessage {
                if !passwordValidated {
                    Text("Password cannot be empty")
                        .foregroundColor(.accentColor)
                }
            }
            if loginViewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    .padding()
            } else {
                loginButtonView
                signUpButtonView
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $loginViewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(loginViewModel.alertMessage), dismissButton: .default(Text("OK"), action: {
                loginViewModel.showAlert = false
                loginViewModel.alertMessage = ""
            }))
        }
        .fullScreenCover(isPresented: $showSignUpScreen) {
            SignUpView()
        }
    }
    
    // Login Button
    var loginButtonView: some View {
        VStack {
            Button {
                if !passwordValidated {
                    showPasswordValidationMessage.toggle()
                }
                if !userIdValidated {
                    showUserValidationMessage.toggle()
                }
                Task {
                    await loginViewModel.loginApiEvent(userId: self.userId, password: self.password)
                    userManager.loggedIn = true
                }
            } label: {
                Text("Login")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(5)
            .padding(.horizontal, 15)
            .padding(.top, 30)
            .disabled(userId.isEmpty || password.isEmpty)
        }
    }
    
    var signUpButtonView: some View {
        VStack {
            Button {
                showSignUpScreen.toggle()
            } label: {
                Text("Sign Up")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(5)
            .padding(.horizontal, 15)
            .padding(.top, 30)
        }
    }
    
    var body: some View {
        NavigationView {
            loginView
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
