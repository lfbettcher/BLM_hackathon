///File description: Know My Rights page.
///User can tap on a container to learn more about individual rights.
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';

class MyRights extends StatefulWidget {
  @override
  _MyRightsState createState() => _MyRightsState();
}

class _MyRightsState extends State<MyRights> {
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
                title: new Text("Know My Rights")
            ),

            ///body
            ///to be implemented

          );
         }
        else{
          return Loading();
        }
      }
    );
  }
}
