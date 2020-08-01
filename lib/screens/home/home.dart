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
import 'package:blmhackathon/screens/home/menuItem.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/policeComplaint_page1.dart';
import 'package:blmhackathon/screens/menuActions/notifyOfArrest/notifyOfArrest.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
            SizedBox(height: 20),
            Text("I need to...", style: TextStyle(color: color1, fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            MenuItem(menuName: "Know my rights", route: MyRights(), icon: Icon(Icons.library_books, color: color3), color: color5),
            SizedBox(height: 20),
            MenuItem(menuName: "Access my emergency contacts", route: EmergencyContacts(), icon: Icon(Icons.import_contacts, color: color3), color: color2),
            SizedBox(height: 20),
            MenuItem(menuName: "Document my situation", route: DocumentSituation(), icon: Icon(FontAwesome5.save, color: color3), color: color5),
            SizedBox(height: 20),
            MenuItem(menuName: "Create a police complaint", route: PoliceComplaintPage1(), icon: Icon(Icons.folder_open, color: color3), color: color2),
            SizedBox(height: 20),
            MenuItem(menuName: "Notify a contact of my arrest", route: NotifyArrest(), icon: Icon(Icons.phone_iphone, color: color3), color: color5),
          ],),
        )

      ),
    );
  }
}
