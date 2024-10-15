//
//  AuthViewModel.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import Foundation
import FirebaseAuth // for User DataType
import AuthenticationServices // communicates with apple server
import CryptoKit // passes data in a secure way

class AuthViewModel: ObservableObject {
  @Published var user: User?
  var currentNonce: String? // for unique Key
  
  /// A RECOMMENDED CODE FROM THE FIREBASE DOCUMENTATION
  func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: [Character] =  Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    while remainingLength > 0 {
      let randoms: [UInt8] = (0 ..< 16).map { _ in
        var random: UInt8 = 0
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
        if errorCode != errSecSuccess {
          fatalError( "Unable to generate nonce. SecRandomCopyBytesfailed with OSStatus \(errorCode)")
        }
        return random
      }
      randoms.forEach { random in
        if remainingLength == 0 {
          return
        }
        if random < charset.count {
          result.append(charset[Int(random)])
          remainingLength -= 1
        }
      }
    } // end while
    return result
  }
  
  /// SHA-256 protocol, cryptography protocol used also in the bitcoin blockchain
  func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
      String(format: "%02x", $0)
    }.joined()
    return hashString
  }
  
  func listenToAuthState() {
    Auth.auth().addStateDidChangeListener { [weak self] _, user in
      guard let self = self else {
        return
      }
      self.user
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
    } catch let signOutError as NSError {
      print("Error signing out")
    }
  }
  
}
