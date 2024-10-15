//
//  NoteViewModel.swift
//  Note
//
//  Created by Teodor Brankovic on 04.09.24.
//

import FirebaseFirestore

class NoteViewModel: ObservableObject { // allows instances of this class to be used inside views later
  
  @Published var notes = [Note]() // tell our program to reload when changes happen with our Model
  
  private var databaseReference = Firestore.firestore().collection("Notes")  // zugriff auf Daten der Datenbank
  
  ///
  /// FUNCTION TO ADD DATA
  ///
  func addData(title: String) {
    do {
      _ = try databaseReference.addDocument(data: ["title": title])
    }
    catch {
      print(error.localizedDescription)
    }
  } // end func
  
  ///
  /// FUNCTION TO FETCH DATA
  ///
  func fetchData() {
    
    databaseReference.addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("no documents")
        return
      }
      self.notes = documents.compactMap {
        QueryDocumentSnapshot -> Note? in
        return try? QueryDocumentSnapshot.data(as: Note.self)
      }
    }
  } // end func
  
  ///
  /// FUNCTION TO UPDATE DATA
  ///
  func updateData(title: String, id: String) {
    databaseReference.document(id).updateData(["title" : title]) { error in // pass the ID to identify
      if let error = error {
        print(error.localizedDescription)
      } else {
        print("Note updated successfully")
      }
    }
  }
  
  ///
  /// FUNCTION TO DELETE DATA
  ///
  func deleteData(at indexSet: IndexSet) {
    indexSet.forEach { index in
      let note = notes[index]
      databaseReference.document(note.id ?? "").delete { error in
        if let error = error {
          print ("\(error.localizedDescription)")
        } else {
          print("Note with ID \(note.id ?? "") deleted")
        }
      }
    }
  }
  
}
