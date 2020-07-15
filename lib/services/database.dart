///File description: This contains database functions for storing documents.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blmhackathon/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection = Firestore.instance.collection('users');

  ///new document created upon registration
  Future createUserDocument(String name) async {
    return await userCollection.document(uid).setData({
      'name': name,
    });
  }

  ///************Data Streams******************///
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
    );
  }

  ///method for formatting user document info
  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){  ///function is fired for each doc in document
      return UserData(
        name: doc.data['name'] ?? '',
      );
    }).toList();
  }

  ///get all user info across the app that we can then listen in on
  Stream<List<UserData>> get userDataList {
    return userCollection.snapshots().
    map(_userListFromSnapshot);
  }

  /// get specific user document stream
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot); ///retrieve the document with this specific UID (as defined from above this file)
    ///the UID is the id of the specific user that is logged in
  }
}
