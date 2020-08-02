///File description: Home page for selecting options
import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:provider/provider.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData> (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        return Scaffold(

          ///menu slider window
          drawer: NavigationMenu(),

          ///app bar
          appBar: new AppBar(
              title: new Text("About Defenderr")
          ),

          ///body
          body: Center(
              child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Text("Defenderr is an app designed to help you out in "
                          "situations involving the police.\n\nWe want to make sure "
                          "you know your rights, help you gather the information "
                          "needed to document the situation, and keep you safe.\n\n"
                          "We are not lawyers and laws vary from state to state. "
                          "Please consult a lawyer for legal advice.\n",
                          style: TextStyle(fontSize: defaultFontSize)),
                    ],
                  )
              )
          )
        );
      }
    );
  }
}