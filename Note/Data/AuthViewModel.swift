//
//  AuthViewModel.swift
//  Note
//
//  Created by Teodor Brankovic on 05.09.24.
//

import Foundation
import FirebaseAuth

///
/// class to communicate with FIrebase Authenticate (
///

final class AuthViewModel: ObservableObject {
  @Published var user: User?
  
  
  /// listens to changes in users' sessions
  func listenToAuthState() {
    Auth.auth().addStateDidChangeListener { [weak self] _, user in
      guard let self = self else { return }
    }
    self.user = user
  }
  
  /// function to sign-in
  func signIn(emailAdress: String, password: String) {
    Auth.auth().signIn(withEmail: emailAdress, password: password) { result, error in
      if let error = error {
        print("an error occured: \(error.localizedDescription)")
        return
      }
    }
  }
  
  /// function to create an account
  func signUp(emailAddress: String, password: String) {
    Auth.auth().createUser(withEmail: emailAddress, password: password) { result, error in
      if let error = error {
        print("an error occured: \(error.localizedDescription)")
        return
      }
    }
  }
  
  /// function to logout
  func signOut() {
    do {
      try Auth.auth().signOut()
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
  }
  
  /// function to reset password
  func resetPassword(emailAddress: String) {
    Auth.auth().sendPasswordReset(withEmail: emailAddress)
  }
  
}
