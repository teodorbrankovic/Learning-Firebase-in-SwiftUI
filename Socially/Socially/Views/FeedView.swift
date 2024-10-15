//
//  FeedView.swift
//  Socially
//
//  Created by Sullivan De carli on 13/12/2022.
//

import SwiftUI
import FirebaseFirestore

struct FeedView: View {
  @State private var showSheet: Bool = false
  @FirestoreQuery(collectionPath: "Posts") var posts: [Post] // with this attribute we don't need to implement a fetch function, great feature from the Firebase API
  
  var body: some View {
    NavigationStack {
      
      List(posts) { posts in
        AsyncImage(url: URL(string: posts.imageURL ?? "")) { phase in
          switch phase {
          case .empty:
            EmptyView()
          case .success(let image):
            image
              .resizable()
              .frame(width: 300, height: 200)
          case .failure(let error):
            Image(systemName: "photo")
          @unknown default:
            EmptyView()
          }
        }
        
        VStack(alignment: .leading) {
          Text(posts.description ?? "")
            .font(.headline)
            .padding(12)
          Text("Published on the \(posts.datePublished?.formatted() ?? "")") // formatted -> Date typ to String type
            .font(.caption)
        }
        
      }.listStyle(GroupedListStyle()) // end List
        .toolbar {
          ToolbarItem(placement: .confirmationAction) {
            Button {
              showSheet.toggle()
            }  label: {
              Image(systemName: "square.and.pencil")
                .imageScale(.large)
            }.sheet(isPresented: $showSheet) {
              PostView()
            }
          } // end tbi
        } // end tb
      
    } // end NS
    
  }
}

struct FeedView_Previews: PreviewProvider {
  static var previews: some View {
    FeedView()
  }
}
