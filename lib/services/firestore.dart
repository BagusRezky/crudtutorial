import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get colection of note
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // CREATE note
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  // READ note
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  // UPDATE note
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }

  Future<String?> getNoteByID(String docID) async {
    DocumentSnapshot doc = await notes.doc(docID).get();
    return doc['note'];
  }
}
