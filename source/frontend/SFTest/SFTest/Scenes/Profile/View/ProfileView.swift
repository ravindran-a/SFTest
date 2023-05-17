//
//  ProfileView.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userManager: UserManager
    
    var profileVIew: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 20) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFit()
                .foregroundColor(Color.accentColor)
            Text("Todo List")
                .foregroundColor(Color.accentColor)
            Spacer()
            logoutButtonView
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Login Button
    var logoutButtonView: some View {
        VStack {
            Button {
                userManager.logoutUser()
                userManager.loggedIn = false
            } label: {
                Text("Logout")
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
            profileVIew
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
