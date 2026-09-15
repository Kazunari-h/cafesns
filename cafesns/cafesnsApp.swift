//
//  cafesnsApp.swift
//  cafesns
//
//  Created by Kazunari Hirosawa on 2026/06/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct cafesnsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
