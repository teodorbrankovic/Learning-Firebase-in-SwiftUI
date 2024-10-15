//
//  DetailsView.swift
//  Note
//
//  Created by Teodor Brankovic on 04.09.24.
//

import SwiftUI

struct DetailsView: View {
  var note: Note
  @State private var presentAlert = false // handle presentation of our alert
  @State private var titleText: String = "" // to follow entry of our textfield
  @ObservedObject private var viewModel = NoteViewModel()
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack {
          Text(note.title ?? "")
            .font(.system(size: 22, weight: .regular))
            .padding()
          Spacer()
        }
      } // end SView
    } // end NStack
    .navigationTitle("Details")
    .toolbar {
      ToolbarItemGroup(placement: .confirmationAction) {
        
        Button {
          presentAlert = true
        } label: {
          Text("Edit").bold()
        }
        .alert("Note", isPresented: $presentAlert, actions: {
          TextField("\(note.title ?? "")", text: $titleText)
          Button("Update", action: {
            self.viewModel.updateData(title: titleText, id: note.id ?? "")
            titleText = ""
          })
          Button("Cancel", role: .cancel, action: {
            presentAlert = false
            titleText = ""
          })
        }, message: {
          Text("Write your new note")
        }) // end alert
        
      } // end TBGroup
    } // end tb
  }
}

struct DetailsView_Previews: PreviewProvider {
  static var previews: some View {
    
    DetailsView(note: Note(id: "bKrivNkYirmMvHyAUBWv", title:
                            "Issues are never simple. One thing I'm proud of is that veryrarely will you hear me simplify the issues.Barack Obama"))
  }
}
