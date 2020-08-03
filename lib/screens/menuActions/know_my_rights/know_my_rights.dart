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
//import 'dart:convert'; // for json

class MyRights extends StatefulWidget {
  @override
  _MyRightsState createState() => _MyRightsState();
}

class _MyRightsState extends State<MyRights> {

  static final bodyTextSize = 20.0;

  List<Rights> rightsList = [
    Rights(
        true, // isExpanded
        "Your Rights", // header
        Padding( // body text
            padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
            child: DefaultTextStyle(
                style: TextStyle(fontSize: bodyTextSize, color: Colors.black),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("\u2022 You have the right to remain silent"),
                      Text("\u2022 You do not have to answer questions about where you are going, what you are doing, where you live, or your citizenship"),
                      Text("\u2022 You do not have to consent to a search"),
                      Text("(In some states you may be required to provide your name)", style: TextStyle(fontStyle: FontStyle.italic)),
                    ]
                )
            )
        )
    ),
    Rights(
        false, // isExpanded
        "Police are questioning me", // header
        Padding( // body text
            padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
            child: DefaultTextStyle(
                style: TextStyle(fontSize: bodyTextSize, color: Colors.black),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("\u2022 Say you wish to remain silent"),
                      Text("\u2022 Do not answer questions"),
                      Text("\u2022 Do not lie or give false documents"),
                    ]
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
                style: TextStyle(fontSize: bodyTextSize, color: Colors.black),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("\u2022 Turn off the car, turn on the light inside the car, open the window partway"),
                      Text("\u2022 Put hands on steering wheel"),
                      Text("\u2022 Tell officer before reaching for something"),
                      Text("\u2022 Avoid sudden movements"),
                      Text("\u2022 Keep your hands where the officer can see them"),
                    ]
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
                style: TextStyle(fontSize: bodyTextSize, color: Colors.black),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("\u2022 Do not resist arrest"),
                      Text("\u2022 Say you wish to remain silent"),
                      Text("\u2022 Don't answer any questions"),
                      Text("\u2022 Ask for a lawyer"),
                    ]
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
                style: TextStyle(fontSize: bodyTextSize, color: Colors.black),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("\u2022 Do not invite the officer in"),
                      Text("\u2022 Talk to them through the door and ask for ID"),
                      Text("\u2022 If they have a warrant, ask them to slip it under the door or hold it up so you can read it"),
                      Text("\u2022 Warrant should be signed by a judge and list your address or name"),
                      Text("\u2022 Even with a warrant, you have the right to remain silent"),
                    ]
                )
            )
        )
    ),
  ];

  @override
  Widget build(BuildContext context) {


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
                      padding: EdgeInsets.all(14.0),
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