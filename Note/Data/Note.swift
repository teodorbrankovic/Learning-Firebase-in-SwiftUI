//
//  File.swift
//  Note
//
//  Created by Teodor Brankovic on 04.09.24.
//

import Foundation
import FirebaseFirestore

struct Note: Codable {
    @DocumentID var id: String? // help us map the document correctly with the identifier from Firebase
    var title: String?
}
