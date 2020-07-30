///File description: Know My Rights page.
///User can tap on a container to learn more about individual rights.
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'dart:convert'; // for json

class MyRights extends StatefulWidget {
  static final String rightsJson = '{"rights": [{"title": "I\'ve been pulled over", "body": "\u2022 do this thing"}, {"title": "Police are at my door", "body": "\u2022 do this thing \u2022 do this other thing"}]}';
  static final List rightsList = jsonDecode(rightsJson)["rights"] as List;
  final List<Rights> list = rightsList.map((rights) => Rights.fromJson(rights)).toList();

  @override
  _MyRightsState createState() => _MyRightsState(list);
}

class _MyRightsState extends State<MyRights> {
  List<Rights> _list;

  _MyRightsState(this._list);

  _onExpansion(int index, bool isExpanded) {
    setState(() {
      _list[index].isExpanded = !(_list[index].isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    List<ExpansionPanel> myRights = [];
    for (int i = 0, li = _list.length; i < li; i++) {
      var expansionData = _list[i];
      myRights.add(ExpansionPanel(
        canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(expansionData.title,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold
                    )
                )
            );
          },
          body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(expansionData.body,
                  style: TextStyle(
                      fontSize: 20.0,
                  )
              )
          ),
          isExpanded: expansionData.isExpanded
      )
      );
    }

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
                    title: new Text("Know My Rights")
                ),

                ///body
                body: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      child: new ExpansionPanelList(
                          children: myRights, expansionCallback: _onExpansion
                      ),
                    )
                )
            );
          } else {
            return Loading();
          }
        }
    );
  }
}

class Rights {
  String title, body;
  bool isExpanded;

  Rights(this.title, this.body, {this.isExpanded = false});

  factory Rights.fromJson(dynamic json) {
    return Rights(json["title"] as String, json["body"] as String);
  }
}