import 'package:blmhackathon/models/policeBadge.dart';
import 'package:blmhackathon/models/witness.dart';
///File description: This contains database functions for storing documents.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/models/witness.dart';
import 'package:blmhackathon/models/contact.dart';

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
        phone: doc.data['phone'] ?? '',
        altPhone: doc.data['altPhone'] ?? ''
      );
    }).toList();
  }

  ///method for getting emergency contact document info
  List<Contact> _contactListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Contact(
          contactId: doc.documentID,
          name: doc.data['name'] ?? '',
          email: doc.data['email'] ?? '',
          phone: doc.data['phone'] ?? '',
          altPhone: doc.data['altPhone'] ?? ''
      );
    }).toList();
  }

  ///method for getting police badge number
  List<Badge> _policeBadgeListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Badge(
        badgeId: doc.documentID,
        badgeNumber: doc.data['badgeNumber'],
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

  /// get all emergency contacts
  Stream<List<Contact>> get contactData{
    return userCollection.document(uid).collection("emergency contacts").snapshots().map(_contactListFromSnapshot);
  }

  /// get all police badges
  Stream<List<Badge>> get badgeData{
    return userCollection.document(uid).collection("policeBadges").snapshots().map(_policeBadgeListFromSnapshot);
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
    return await userCollection.document(uid).collection("witnesses").document().setData({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'altPhone' : altPhone
    });
  }

  ///create a new emergency contact
  Future createNewEmergencyContactDocument(String name, String email, String phone, String altPhone) async {
    return await userCollection.document(uid)
        .collection("emergency contacts")
        .document()
        .setData({
      'name': name,
      'email': email,
      'phone': phone,
      'altPhone': altPhone
    });
  }

  ///create a new police badge
  Future createNewPoliceBadgeDocument(String badgeNumber) async {
    return await userCollection.document(uid).collection("policeBadges").document().setData({
      'badgeNumber' : badgeNumber,
    });
  }

  ///**********************Deleting existing documents****************************///

  Future deleteWitness(String witnessId) async {
    return await userCollection.document(uid).collection("witnesses").document(witnessId).delete();
  }

  Future deleteEmergencyContact(String contactId) async {
    return await userCollection.document(uid).collection("emergency contacts").document(contactId).delete();
  }

  Future deleteBadge(String badgeId) async {
    return await userCollection.document(uid).collection("policeBadges").document(badgeId).delete();
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

  Future updateEmergencyContact(Contact contact, String newContactName, String newContactEmail, String newContactPhone, String newContactAltPhone) async {
    return await userCollection.document(uid).collection("emergency contacts").document(contact.contactId).updateData(
        {
          'name' : newContactName == null ? contact.name : newContactName,
          'email' : newContactEmail == null ? contact.email : newContactEmail,
          'phone' : newContactPhone == null ? contact.phone : newContactPhone,
          'altPhone' : newContactAltPhone == null ? contact.altPhone : newContactAltPhone,
        });
  }
}
