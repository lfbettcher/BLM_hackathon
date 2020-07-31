import 'package:flutter/cupertino.dart';
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
  @override
  _MyRightsState createState() => _MyRightsState();
}

class _MyRightsState extends State<MyRights> {

  List<Rights> rightsList = [
    Rights(
        true, // isExpanded
        "General information", // header
        Padding( // body text
          padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
            child: DefaultTextStyle(
                style: TextStyle(fontSize: 24, color: Colors.black),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                        children: <Widget>[
                          Text("\u2022 Left aligned"),
                          Text("\u2022 Left aligned"),
                          Text("\u2022 Left aligned")
                        ]
                    )
                )
              )
        )
    ),
    Rights(
        false, // isExpanded
        "I've been pulled over", // header
        Padding( // body text
            padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
            child: DefaultTextStyle(
                style: TextStyle(fontSize: 24, color: Colors.black),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                        children: <Widget>[
                          Text("\u2022 Left aligned"),
                          Text("\u2022 Left aligned"),
                          Text("\u2022 Left aligned")
                        ]
                    )
                )
            )
        )
    ),
    Rights(
        false, // isExpanded
        "I'm being arrested", // header
        Padding( // body text
            padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
            child: DefaultTextStyle(
                style: TextStyle(fontSize: 24, color: Colors.black),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                        children: <Widget>[
                          Text("\u2022 Left aligned"),
                          Text("\u2022 Left aligned"),
                          Text("\u2022 Left aligned")
                        ]
                    )
                )
            )
        )
    ),
    Rights(
        false, // isExpanded
        "Police are at my door", // header
        Padding( // body text
            padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
            child: DefaultTextStyle(
                style: TextStyle(fontSize: 24, color: Colors.black),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                        children: <Widget>[
                          Text("\u2022 Left aligned"),
                          Text("\u2022 Left aligned"),
                          Text("\u2022 Left aligned")
                        ]
                    )
                )
            )
        )
    ),
  ];

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
                    title: new Text("Know My Rights")
                ),

                ///body
                body: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            rightsList[index].isExpanded = !rightsList[index].isExpanded;
                          });
                        },
                        children: rightsList.map((Rights item) {
                          return ExpansionPanel(
                              canTapOnHeader: true,
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return ListTile(
                                    title: Text(
                                      item.header,
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                );
                              },
                              isExpanded: item.isExpanded,
                              body: item.body
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}

class Rights {
  bool isExpanded;
  String header;
  Widget body;

  Rights(this.isExpanded, this.header, this.body);

//  factory Rights.fromJson(dynamic json) {
//    return Rights(json["title"] as String, json["body"] as String);
}