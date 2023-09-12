//
//  ZespaceApp.swift
//  Zespace
//
//  Created by Anthony on 30/05/2022.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ZespaceApp: App {
    var body: some Scene {
        WindowGroup {
           // ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
            SplashView()
        }
    }
}
