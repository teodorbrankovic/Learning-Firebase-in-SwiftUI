//
//  FormView.swift
//  Note
//
//  Created by Teodor Brankovic on 04.09.24.
//

import SwiftUI

struct FormView: View {
  @Environment(\.dismiss) var dismiss
  @State var titleText = ""
  @ObservedObject private var viewModel = NoteViewModel() // binding between View and ViewModel
  
    var body: some View {
      NavigationStack {
        
        Form {
          
          Section {
            TextEditor(text: $titleText).frame(minHeight: 200)
          }
            Button(action: {
              self.viewModel.addData(title: titleText) // upload data
              titleText = ""
              dismiss()
            }) {
              Text ("Save now")
            }.disabled(self.titleText.isEmpty).foregroundStyle(.blue)
          
          
        } // end Form
        .navigationTitle("Post")
        .toolbar {
          ToolbarItemGroup(placement:
              .destructiveAction) {
                Button("Cancel") {
                  dismiss()
                }
              }
        }
      } // end NS
      
      
    }
}

//#Preview {
//    FormView()
//}
