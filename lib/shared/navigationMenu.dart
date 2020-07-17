///File description: This is a widget for the hide-able menu bar that comes up when the menu icon is tapped.
///It is meant to be reusable among the screens.
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/screens/home/home.dart';

class NavigationMenu extends StatefulWidget {
  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData, //give it the ID, which we can retrieve from the Provider, userData is the stream from database.dart
      builder: (context, snapshot){
        if (snapshot.hasData){
          UserData userData = snapshot.data;
          return Container(
            width: 180,
            child: new Drawer(
                child: ListView(
                    children: <Widget>[
                      ///user name, email, and profile picture if avail
                      new UserAccountsDrawerHeader(
                        accountName: new Text('Welcome, ${userData.name}',
                        style: TextStyle(fontSize: 20)),
                      ),

                      ///home navigation menu item
                      new ListTile(
                        title: Row(children: <Widget>[
                          Icon(Icons.home),
                          SizedBox(width: 5),
                          Text("Home")
                        ],),
                        onTap: (){
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => new Home()));
                        },
                      ),

                      ///settings navigation menu item
                      new ListTile(
                        title: Row(children: <Widget>[
                          Icon(Icons.settings),
                          SizedBox(width: 5),
                          Text("Settings")
                        ],),
                        onTap: (){
                        },
                      ),

                      ///log out navigation menu item
                      new ListTile(
                        title: Row(children: <Widget>[
                          Icon(Icons.exit_to_app),
                          SizedBox(width: 5),
                          Text("Log Out")
                        ],),
                        onTap: (){
                          _auth.signOut();
                        },
                      )

                    ]
                )
            ),
          );
        }
        else{
          return Loading();
        }
      }
    );
  }
}

