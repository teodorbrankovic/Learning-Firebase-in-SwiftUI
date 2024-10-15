//
//  PostVIew.swift
//  Socially
//
//  Created by Teodor Brankovic on 05.09.24.
//

import SwiftUI
import PhotosUI

struct PostView: View {
  
  @State private var description: String = ""
  @State var data: Data? // to pass data while selecting picture
  @State var selectedItem: [PhotosPickerItem] = [] // which picture user is selecting
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject private var viewModel = PostViewModel()
  
  var body: some View {
    NavigationStack {
      
      Form {
        Section {
          PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, selectionBehavior: .default
                       , matching: .images, preferredItemEncoding: .automatic) {
            if let data = data, let image = UIImage(data: data) {
              Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
            } else {
              Label("Select a picture", systemImage: "photo.on.rectangle.angled")
            }
          }.onChange(of: selectedItem) { newValue in
            guard let item = selectedItem.first else { return }
            item.loadTransferable(type: Data.self) { result in
              switch result {
              case .success(let data):
                if let data = data {
                  self.data = data
                }
              case .failure(let failure):
                print("Error : \(failure.localizedDescription)")
              }
            }
          } // end onC
        } // end Section
        
        Section {
          TextField("Add a description", text: $description, axis: .vertical)
            .lineLimit(6)
        }
        
        Section {
          Button("Post") {
            Task { // Task is necesseary for "await"
              await self.viewModel.addData(description: description, datePublished: Date(), data: data!)
            }
            presentationMode.wrappedValue.dismiss()
          }
          .disabled(data == nil) // if no image selected
        } // end Section
      } // end Form
      .navigationTitle("Post")
      .toolbar {
        ToolbarItemGroup(placement: .cancellationAction) {
          Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
          }
        }
      } // end tb
    } // end NS
    
  }
}

#Preview {
  PostView()
}
