//
//  SignUpView.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import FirebaseAnalytics

struct SignUpView: View {
  @ObservedObject private var authModel = AuthViewModel()
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .center) {
        Spacer()
        Button(action: {
          Analytics.logEvent("analytics_test_button", parameters: nil)
        }, label: {
          Text("Test Button for Firebase Analytics")
        })
        .backgroundStyle(.black)
        .foregroundStyle(.black)
        
        Spacer()
        
        /// Sign In with Apple button
        SignInWithAppleButton(onRequest: {request in
          let nonce = authModel.randomNonceString()
          request.requestedScopes = [.email]
          request.nonce = authModel.sha256(nonce)
        }, onCompletion: { result in
          // Completion
          switch result { // main switch
          case .success(let authResults):
            switch authResults.credential { // cascade swtich
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
              guard let nonce = authModel.currentNonce else { fatalError("Invalid State: no login request")}
              guard let appleIDToken = appleIDCredential.identityToken else { fatalError("Invalid State: no login request")}
              guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data")
                return
              }
              let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString,
              rawNonce: nonce)
              Auth.auth().signIn(with: credential) {
                (authResult, error) in
                if (error != nil) {
                  print(error?.localizedDescription as Any)
                  return
                }
                print("signed in")
                guard let user = authResult?.user else { return }
                
                let userData = ["email": user.email, "uid": user.uid]
                Firestore.firestore().collection("User").document(user.uid).setData(userData) { _ in
                  print("DEBUG: Did upload user data")
                }
              } // end auth
              print("\(String(describing: Auth.auth().currentUser?.uid))")
              
            default:
              break
            }
            
          default:
            break
          } // end main switch
        }
        ) // end SignInWithApple
        .signInWithAppleButtonStyle(.black)
        .frame(width: 290, height: 45, alignment: .center)
        
      } // end VS
    } // end SG
  }
}


struct SignUpView_Previews: PreviewProvider {
  static var previews: some View {
    SignUpView()
  }
}
