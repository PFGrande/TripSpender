//
//  TripSpendingAppApp.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/12/24.
//

import SwiftUI
//import FirebaseAuth
import FirebaseCore

// https://console.firebase.google.com/u/0/project/tripspendingapp/overview
class AppDelegate: NSObject, UIApplicationDelegate {

    func application
        (
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
        ) -> Bool {
            FirebaseApp.configure()

            return true

        }
}


@main
struct TripSpendingAppApp: App {
    // register app delegate for Firebase setup

      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
