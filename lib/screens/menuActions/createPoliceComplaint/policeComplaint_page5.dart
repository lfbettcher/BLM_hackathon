///File description: Police complaint page 5. This page lets users select the involved license plates of the incident.
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
import 'package:blmhackathon/models/witness.dart';
import 'package:blmhackathon/models/dateTimeLocationStamp.dart';
import 'package:blmhackathon/models/licensePlate.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/policeComplaint_page6.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/helperSelectionChips/selectLicensePlateWidget.dart';

class PoliceComplaintPage5 extends StatefulWidget {
  final DateTimeLocationStamp dateTimeLocation;
  final List<Badge> badges;
  final List<Witness> witnesses;
  final String documentName;
  PoliceComplaintPage5({this.documentName, this.dateTimeLocation, this.badges, this.witnesses});

  @override
  _PoliceComplaintPage5State createState() => _PoliceComplaintPage5State();
}

class _PoliceComplaintPage5State extends State<PoliceComplaintPage5> {
  List<License> _licenses = <License>[];

  void toggleSelect(License license){
    setState(() {
      if (_licenses.contains(license)){
        _licenses.removeWhere((License removeLicense){
          return license == removeLicense;
        });
      }
      else{
        _licenses.add(license);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return StreamBuilder<List<License>>(
        stream: DatabaseService(uid: user.uid).licenseData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<License> licenses = snapshot.data;

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
                          ProgressBar(percent: 0.5),
                          SizedBox(height: 30),
                          Text("Select all involved license plates: ", style: TextStyle(fontSize: defaultFontSize)),
                          SizedBox(height: 30),
                          Expanded(
                            child:
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: licenses.length,
                                itemBuilder: (context, index){
                                  return Column(
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      SelectLicensePlateWidget(license: licenses[index], toggleSelect: toggleSelect)
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
                          builder: (context) => PoliceComplaintPage6(documentName: widget.documentName, dateTimeLocation: widget.dateTimeLocation, badges: widget.badges, witnesses: widget.witnesses, licenses: _licenses)));
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
