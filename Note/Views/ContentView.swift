//
//  ContentView.swift
//  Note
//
//  Created by Teodor Brankovic on 04.09.24.
//

import SwiftUI

struct ContentView: View {
  @State private var showingSheet = false
  @State private var postDetent = PresentationDetent.medium
  @ObservedObject private var viewModel = NoteViewModel() // for fetched data in real time
  
  var body: some View {
    
    NavigationStack {
      List(viewModel.notes, id: \.id) { Note in
          NavigationLink(destination: DetailsView(note: Note)) { // go to detailview for every note
            VStack(alignment: .leading) {
              Text(Note.title ?? "")
                .font(.system(size: 22, weight: .regular))
            } // end List VStack
            .frame(maxHeight: 200)
          } // end NLink
      } // end List
      .onAppear(perform: self.viewModel.fetchData) // when View displays fetch Data
      .toolbar {
        ToolbarItemGroup(placement: .bottomBar) {
          Text("\(viewModel.notes.count)") // count of notes
          Spacer()
          
          Button {
            // write a new note
            showingSheet.toggle()
          } label: {
            Image(systemName: "square.and.pencil")
          }
          .imageScale(.large)
          .sheet(isPresented: $showingSheet) {
            FormView().presentationDetents([.large, .medium])
          }
          
        }
      }
    } // end NS
    .navigationTitle("Notes")
  
  }
}

//#Preview {
//  ContentView()
//}
