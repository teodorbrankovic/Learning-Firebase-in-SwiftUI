//
//  NoteApp.swift
//  Note
//
//  Created by Teodor Brankovic on 04.09.24.
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
struct NoteApp: App {
  // register app delegate for Firebase setup
   @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
    var body: some Scene {
        WindowGroup {
          HolderView().environmentObject(AuthViewModel()) // entry of app and state of user session to present right screen
        }
    }
}
