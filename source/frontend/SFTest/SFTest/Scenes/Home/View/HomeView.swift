//
//  HomeView.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var tabSelection: Int = 1
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        if userManager.loggedIn {
            TabView(selection: $tabSelection) {
                TodoListView()
                    .environmentObject(userManager)
                    .tabItem { Label("Todo", systemImage: "list.bullet.below.rectangle") }.tag(1)
                ProfileView()
                    .environmentObject(userManager)
                    .tabItem { Label("Profile", systemImage: "person.crop.circle") }.tag(2)
            }
        } else {
            LoginView()
                .environmentObject(userManager)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
