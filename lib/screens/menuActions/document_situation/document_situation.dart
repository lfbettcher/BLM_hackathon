///File description: Root page for documentation.
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/menuItem.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/licensePlateDocumentation/licensePlateDocumentation.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/policeBadgeDocumentation/policeBadgeDocumentation.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/witnessContacts/witnessContacts.dart';

class DocumentSituation extends StatefulWidget {
  @override
  _DocumentSituationState createState() => _DocumentSituationState();
}

class _DocumentSituationState extends State<DocumentSituation> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot){
          if (snapshot.hasData){
            UserData userData = snapshot.data;
            return Scaffold(
              ///menu slider window
              drawer: NavigationMenu(),

              ///app bar
              appBar: new AppBar(
                  title: new Text("Document My Situation")
              ),

              ///body
              ///to be implemented
              body: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    MenuItem(menuName: "License Plates", route: LicensePlateDocumentation()),
                    SizedBox(height: 20),
                    MenuItem(menuName: "Police Badges", route: PoliceBadgeDocumentation()),
                    SizedBox(height: 20),
                    MenuItem(menuName: "Witness Contacts", route: WitnessContactsDocumentation()),
                  ],
                )
              )
            );
          }
          else{
            return Loading();
          }
        }
    );
  }
}
