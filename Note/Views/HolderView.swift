//
//  HolderView.swift
//  Note
//
//  Created by Teodor Brankovic on 05.09.24.
//

import SwiftUI

struct HolderView: View {
  @EnvironmentObject private var authModel: AuthViewModel
  
  var body: some View {
    Group {
      if authModel.user == nil {
        SignUpView()
      } else {
        ContentView()
      }
    } // end Group
    .onAppear {
      authModel.listenToAuthState()
    }
    
  }
}

//#Preview {
//  HolderView()
//}
