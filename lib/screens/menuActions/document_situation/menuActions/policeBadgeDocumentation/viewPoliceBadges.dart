///File description: View police badges page
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/models/policeBadge.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/policeBadgeDocumentation/badgeCard.dart';

class ViewPoliceBadges extends StatefulWidget {
  @override
  _ViewPoliceBadgesState createState() => _ViewPoliceBadgesState();
}

class _ViewPoliceBadgesState extends State<ViewPoliceBadges> {
  @override
    Widget build(BuildContext context) {
      final user = Provider.of<User>(context);
      final AuthService _auth = AuthService();

      return StreamBuilder<List<Badge>>(
          stream: DatabaseService(uid: user.uid).badgeData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Badge> badges = snapshot.data;
              return Scaffold(
                resizeToAvoidBottomPadding: false,

                ///menu slider window
                drawer: NavigationMenu(),

                ///app bar
                appBar: new AppBar(
                    title: new Text("Police Badges")
                ),

                ///body
                body: Center(
                  child: Container(
                      child: Column(children: <Widget>[
                        SizedBox(height: 30),
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: badges.length,
                              itemBuilder: (context, index){
                                return BadgeCard(badge: badges[index], userId: user.uid);
                              }
                          ),
                        ),
                      ],)
                  ),
                )
              );
            }
            else {
              return Loading();
            }
          }
      );
    }
  }
