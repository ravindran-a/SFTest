//
//  SFTestApp.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import SwiftUI

@main
struct SFTestApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(UserManager.shared)
        }
    }
}
