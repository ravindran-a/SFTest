//
//  SignUpView.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    @State var userId: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var showUserValidationMessage: Bool = false
    @State var showPasswordValidationMessage: Bool = false
    @State var showConfirmPasswordValidationMessage: Bool = false
    @StateObject var signUpViewModel: SignUpViewModel = SignUpViewModel()
    
    private var userIdValidated: Bool {
        !userId.isEmpty
    }
    
    private var passwordValidated: Bool {
        !password.isEmpty
    }
    
    private var confirmPasswordValidated: Bool {
        !confirmPassword.isEmpty
    }
    
    var signupView: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 20) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFit()
                .foregroundColor(Color.accentColor)
            Text("Todo List")
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
            
            SecureField("Confirm Password", text: $confirmPassword)
                .frame(maxWidth: 500.0)
                .textInputAutocapitalization(.never)
                .onChange(of: confirmPassword) { _ in
                    showConfirmPasswordValidationMessage = false
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(showPasswordValidationMessage ? Color.red : Color.gray,
                            lineWidth: 1))
            if showConfirmPasswordValidationMessage {
                if !confirmPasswordValidated {
                    Text("Confirm Password cannot be empty")
                        .foregroundColor(.accentColor)
                }
            }
            if signUpViewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    .padding()
            } else {
                submitButtonView
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Sign Up")
        .navigationBarItems(trailing: closeButton)
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $signUpViewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(signUpViewModel.alertMessage), dismissButton: .default(Text("OK"), action: {
                signUpViewModel.showAlert = false
                signUpViewModel.alertMessage = ""
            }))
        }
    }
    
    var submitButtonView: some View {
        VStack {
            Button {
                if !confirmPasswordValidated {
                    showConfirmPasswordValidationMessage.toggle()
                }
                if !passwordValidated {
                    showPasswordValidationMessage.toggle()
                }
                if !userIdValidated {
                    showUserValidationMessage.toggle()
                }
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
    
    var closeButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
        }
    }
    
    var body: some View {
        NavigationView {
            signupView
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
