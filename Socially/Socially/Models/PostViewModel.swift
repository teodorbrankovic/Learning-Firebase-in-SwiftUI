//
//  PostViewModel.swift
//  Socially
//
//  Created by Teodor Brankovic on 05.09.24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage


class PostViewModel: ObservableObject {
  
  @Published var posts = [Post]()
  private var databaseReference = Firestore.firestore().collection("Posts")
  let storageReference = Storage.storage().reference().child("\(UUID().uuidString)") // = different unique ID for every asset
  
  // function to post data
  func addData(description: String, datePublished: Date, data: Data) async {
    do {
      _ = try await storageReference.putData(data, metadata: nil) { (metadata, error) in
        guard let metadata = metadata else { return }
        self.storageReference.downloadURL { (url, erron) in
          guard let downloadURL = url else { return }
          self.databaseReference.addDocument(data: [ "description": description, "datePublished": datePublished, "imageURL": downloadURL.absoluteString])
        }
      } // end try await
    } catch {
      print(error.localizedDescription)
    }
  }
  
}
