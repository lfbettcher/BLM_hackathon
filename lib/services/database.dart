import 'package:blmhackathon/models/witness.dart';
///File description: This contains database functions for storing documents.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/models/witness.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection = Firestore.instance.collection('users');

  ///**********************Object Formatters****************************///

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

  ///method for getting witness document info
  List<Witness> _witnessListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Witness(
        witnessId: doc.documentID,
        name: doc.data['name'] ?? '',
        email: doc.data['email'] ?? '',
        phone: doc.data['name'] ?? '',
        altPhone: doc.data['altPhone'] ?? ''
      );
    }).toList();
  }

  ///**********************Data Streams****************************///

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

  /// get all witnesses
  Stream<List<Witness>> get witnessData{
    return userCollection.document(uid).collection("witnesses").snapshots().map(_witnessListFromSnapshot);
  }

  ///**********************Creating new documents****************************///

  ///new document created upon registration
  Future createUserDocument(String name) async {
    return await userCollection.document(uid).setData({
      'name': name,
    });
  }
  ///create a new witness
  Future createNewWitnessDocument(String name, String email, String phone, String altPhone) async {
    print("creating");
    print(uid);
    return await userCollection.document(uid).collection("witnesses").document().setData({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'altPhone' : altPhone
    });
  }

  ///**********************Deleting existing documents****************************///

  Future deleteWitness(String witnessId) async {
    return await userCollection.document(uid).collection("witnesses").document(witnessId).delete();
  }

///**********************Updating existing documents****************************///

  Future updateWitness(Witness witness, String newWitnessName, String newWitnessEmail, String newWitnessPhone, String newWitnessAltPhone) async {
    return await userCollection.document(uid).collection("witnesses").document(witness.witnessId).updateData(
        {
          'name' : newWitnessName == null ? witness.name : newWitnessName,
          'email' : newWitnessEmail == null ? witness.email : newWitnessEmail,
          'phone' : newWitnessPhone == null ? witness.phone : newWitnessPhone,
          'altPhone' : newWitnessAltPhone == null ? witness.altPhone : newWitnessAltPhone,
        });
  }
}
