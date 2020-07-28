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
  _MyRightsState createState() => _MyRightsState([
    Rights("Title1", "body text", false),
    Rights("Title2", "body text", false),
    Rights("Title3", "body text", false),
  ]);
}

class _MyRightsState extends State<MyRights> {
  List<Rights> _list;

  _MyRightsState(this._list);

  _onExpansion(int index, bool isExpanded) {
    setState(() {
      _list[index].expanded = !(_list[index].expanded);
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
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(expansionData._title,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold
                    )
                )
            );
          },
          body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(expansionData._body,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic
                  )
              )
          ),
          isExpanded: expansionData._expanded
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
                      margin: const EdgeInsets.all(8.0),
                      child: new ExpansionPanelList(
                          children: myRights, expansionCallback: _onExpansion),
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
  String _title, _body;
  bool _expanded;

  Rights(this._title, this._body, this._expanded);

  @override
  String toString() {
    return "Rights(_title: $_title, _body: $_body, _expanded: $_expanded)";
  }

  bool get expanded => _expanded;

  set expanded(bool value) {
    _expanded = value;
  }

  get body => _body;

  set body(value) {
    _body = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

}