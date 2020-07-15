///File description: Home page for selecting options

import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:provider/provider.dart';

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

        ///body
        appBar: new AppBar(
          title: new Text(title)
        ),

      ),
    );
  }
}
