import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/policeComplaint_page4.dart';
///File description: Police complaint page 3. This page lets users select the involved police officers of the incident.
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/progressBar.dart';
import 'package:blmhackathon/models/policeBadge.dart';
import 'package:blmhackathon/models/dateTimeLocationStamp.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/helperSelectionChips/selectPoliceWidget.dart';

class PoliceComplaintPage3 extends StatefulWidget {
  final DateTimeLocationStamp dateTimeLocation;
  final String documentName;
  PoliceComplaintPage3({this.dateTimeLocation, this.documentName});

  @override
  _PoliceComplaintPage3State createState() => _PoliceComplaintPage3State();
}

class _PoliceComplaintPage3State extends State<PoliceComplaintPage3> {
  List<Badge> _officerBadges = <Badge>[];

  void toggleSelect(Badge badge){
    setState(() {
      if (_officerBadges.contains(badge)){
        _officerBadges.removeWhere((Badge removeBadge){
          return badge == removeBadge;
        });
      }
      else {
        _officerBadges.add(badge);
      }
    });
  }

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

              ///menu slider window
              drawer: NavigationMenu(),

              ///app bar
              appBar: new AppBar(
                  title: new Text("Create a new police complaint")
              ),

              ///body
              ///to be implemented
              body: Center(
                  child: Container(
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30),
                          ProgressBar(percent: 0.42),
                          SizedBox(height: 30),
                          Text("Select all involved officers: ", style: TextStyle(fontSize: defaultFontSize)),
                          SizedBox(height: 30),
                          Expanded(
                            child:
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: badges.length,
                                itemBuilder: (context, index){
                                  return Column(
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      SelectPoliceWidget(badge: badges[index], toggleSelect: toggleSelect)
                                    ],
                                  );
                                }
                            ),
                          ),
                        ],
                      )
                  )
              ),
              floatingActionButton: FloatingActionButton.extended(
                label: Row(children: <Widget>[
                  Text("Next", style: TextStyle(fontSize: defaultFontSize, color: color3)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: color3)
                ],),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PoliceComplaintPage4(documentName: widget.documentName, dateTimeLocation: widget.dateTimeLocation, badges: _officerBadges)));
                },
              ),
            );
          }
          else {
            return Loading();
          }
        }
    );
  }
}
