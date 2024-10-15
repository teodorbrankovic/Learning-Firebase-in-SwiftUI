//
//  ProfileView.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import SwiftUI

struct ProfileView: View {
  @ObservedObject private var authModel = AuthViewModel()
  @State private var showSignUp: Bool = false
  
    var body: some View {
      VStack(alignment: .center) {
        if (authModel.user != nil) {
          Form {
            Section("you account") {
              Text(authModel.user?.email ?? "")
            }
            Button {
              authModel.signOut()
            } label: {
              Text("Logout")
                .foregroundStyle(.red)
            }
          } // end Form
        } else {
          Form {
            Section("you account") {
              Text("Seem's like you are not logged in, create an account!")
            }
            Button {
              showSignUp.toggle()
            } label: {
              Text("Sign Up")
                .foregroundStyle(.blue)
                .bold()
            }
            .sheet(isPresented: $showSignUp) {
              SignUpView().presentationDetents([.medium, .large])
            }
          } // end Form
        }
      } // end casc VS
      .onAppear{ authModel.listenToAuthState() }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
