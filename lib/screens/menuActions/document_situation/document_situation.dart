///File description: Root page for documentation.
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuItem.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/witnessContactsDocumentation/viewWitnessContacts.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/policeBadgeDocumentation/viewPoliceBadges.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/licensePlateDocumentation/viewLicensePlates.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/dateTimeStampDocumentation/dateTimeLocationStamp.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:blmhackathon/shared/constants.dart';

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
                    SizedBox(height: 20),
                    MenuItem(menuName: "Police Badges", viewAllItemsRoute: ViewPoliceBadges(), icon: Icon(FontAwesome.id_badge, color: color3), color: color2),
                    SizedBox(height: 20),
                    MenuItem(menuName: "Witness Contacts", viewAllItemsRoute: ViewWitnessContacts(), icon: Icon(FontAwesome.users, color: color3), color: color5),
                    SizedBox(height: 20),
                    MenuItem(menuName: "License Plates", viewAllItemsRoute: ViewLicensePlates(), icon: Icon(FontAwesome.car, color: color3), color: color2),
                    SizedBox(height: 20),
                    MenuItem(menuName: "Create Date/Time/Location Stamp", viewAllItemsRoute: DateTimeLocationStamp(), icon: Icon(FontAwesome.calendar, color: color3), color: color5),
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
