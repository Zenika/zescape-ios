//
//  ZespaceApp.swift
//  Zespace
//
//  Created by Anthony on 30/05/2022.
//

import SwiftUI
import FirebaseCore
import BranchSDK


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
    Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
      print(params as? [String: AnyObject] ?? {})
      // Access and use deep link data here (nav to page, display content, etc.)
    }
      
    Branch.setUseTestBranchKey(true)
      
    Branch.getInstance().validateSDKIntegration()


    return true
  }
}

@main
struct ZespaceApp: App {
    var body: some Scene {
        WindowGroup {
           // ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
            SplashView().onOpenURL(perform: { url in
                Branch.getInstance().handleDeepLink(url)
        })
           
                
        }
    }
}
