import 'package:blmhackathon/screens/home/homeMenuItem.dart';
///File description: Home page for selecting options

import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/screens/menuActions/know_my_rights/know_my_rights.dart';
import 'package:blmhackathon/screens/menuActions/access_emergency_contacts/access_emergency_contacts.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/document_situation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().userDataList,
      child: Scaffold(
        ///menu slider window
        drawer: NavigationMenu(),

        ///app bar
        appBar: new AppBar(
          title: new Text(title)
        ),

        ///body
        body: Center(
          child: Column(children: <Widget>[
            SizedBox(height: 40),
            Text("I need to...", style: TextStyle(color: color1, fontSize: 18)),
            SizedBox(height: 40),
            HomeMenuItem(menuName: "Know my rights", route: MyRights()),
            SizedBox(height: 20),
            HomeMenuItem(menuName: "Access my emergency contacts", route: EmergencyContacts()),
            SizedBox(height: 20),
            HomeMenuItem(menuName: "Document my situation", route: DocumentSituation())
          ],),
        )

      ),
    );
  }
}
