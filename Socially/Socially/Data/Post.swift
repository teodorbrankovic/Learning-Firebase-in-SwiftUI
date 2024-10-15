//
//  Post.swift
//  Socially
//
//  Created by Teodor Brankovic on 05.09.24.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct Post: Identifiable, Decodable {
  @DocumentID var id: String?
  var description: String?
  var imageURL: String?
  @ServerTimestamp var datePublished: Date? // Firebase API and gives us access to the server time
}
