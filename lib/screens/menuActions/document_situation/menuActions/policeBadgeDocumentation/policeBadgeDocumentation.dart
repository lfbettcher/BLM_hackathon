///File description: View police badges page
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';

class PoliceBadgeDocumentation extends StatefulWidget {
  @override
  _PoliceBadgeDocumentationState createState() => _PoliceBadgeDocumentationState();
}

class _PoliceBadgeDocumentationState extends State<PoliceBadgeDocumentation> {
  @override
    Widget build(BuildContext context) {
      final user = Provider.of<User>(context);
      final AuthService _auth = AuthService();

      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              return Scaffold(

                ///menu slider window
                drawer: NavigationMenu(),

                ///app bar
                appBar: new AppBar(
                    title: new Text("Police Badges")
                ),

                ///body
                ///to be implemented

              );
            }
            else {
              return Loading();
            }
          }
      );
    }
  }
