//
//  SignUpView.swift
//  Note
//
//  Created by Teodor Brankovic on 05.09.24.
//

import SwiftUI

struct SignUpView: View {
  @State private var emailAdress: String = ""
  @State private var password: String = ""
  @EnvironmentObject private var authModel: AuthViewModel
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Email", text: $emailAdress)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
          SecureField("Password", text: $password)
        } // end Section
        
        Section {
          Button(action: {
            authModel.signUp(emailAddress: emailAdress, password: password)
            print("\(String(describing: authModel.user))")
          }, label: {
            Text("Sign Up").bold()
          })
        } // end Section2
        
        Section(header: Text("If you already have an account:")) {
          Button(action: {
            authModel.signIn(emailAdress: emailAdress, password: password)
          }, label: {
            Text("Sign In")
          })
        } // end Section3
        
        NavigationLink(destination: ContentView()) {
          Text("ContentView")
        }
      } // end Form
    } // end NS
    .navigationTitle("Welcome")
    .toolbar {
      ToolbarItemGroup(placement: .cancellationAction) {
        Button {
          //showingSheet.toggle()
        } label: {
          Text("Forgot password?")
        }
        //        .sheet(isPresented: $showingSheet) {
        //          ForgotPasswordView()
        //        }
      } // end tbg
    } // end tb
    
  }
}

#Preview {
  SignUpView()
}
