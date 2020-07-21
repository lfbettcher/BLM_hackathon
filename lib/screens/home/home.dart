///File description: Home page for selecting options
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/screens/menuActions/know_my_rights/know_my_rights.dart';
import 'package:blmhackathon/screens/menuActions/access_emergency_contacts/access_emergency_contacts.dart';
import 'package:blmhackathon/screens/menuActions/access_emergency_contacts/addEmergencyContact.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/document_situation.dart';
//import 'package:blmhackathon/screens/home/menuItem.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuItem.dart';
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
            MenuItem(menuName: "Know my rights", viewAllItemsRoute: MyRights()),
            SizedBox(height: 20),
            MenuItem(menuName: "Access my emergency contacts", viewAllItemsRoute: EmergencyContacts(), addNewItemRoute: AddEmergencyContact()),
            SizedBox(height: 20),
            MenuItem(menuName: "Document my situation", viewAllItemsRoute: DocumentSituation())
          ],),
        )

      ),
    );
  }
}
