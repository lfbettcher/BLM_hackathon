///File description: Police complaint page 4. This page lets users select the involved witnesses of the incident.
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
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/helperSelectionChips/selectWitnessWidget.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/policeComplaint_page5.dart';

class PoliceComplaintPage4 extends StatefulWidget {
  final DateTimeLocationStamp dateTimeLocation;
  final List<Badge> badges;
  final String documentName;
  PoliceComplaintPage4({this.documentName, this.dateTimeLocation, this.badges});

  @override
  _PoliceComplaintPage4State createState() => _PoliceComplaintPage4State();
}

class _PoliceComplaintPage4State extends State<PoliceComplaintPage4> {
  List<Witness> _witnesses = <Witness>[];

  void toggleSelect(Witness witness){
    setState(() {
      if (_witnesses.contains(witness)){
        _witnesses.removeWhere((Witness removeWitness){
          return witness == removeWitness;
        });
      }
      else{
        _witnesses.add(witness);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return StreamBuilder<List<Witness>>(
        stream: DatabaseService(uid: user.uid).witnessData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Witness> witnesses = snapshot.data;

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
                          ProgressBar(percent: 0.4),
                          SizedBox(height: 30),
                          Text("Select all involved witnesses: ", style: TextStyle(fontSize: defaultFontSize)),
                          SizedBox(height: 30),
                          Expanded(
                            child:
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: witnesses.length,
                                itemBuilder: (context, index){
                                  return Column(
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      SelectWitnessWidget(witness: witnesses[index], toggleSelect: toggleSelect)
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
                          builder: (context) => PoliceComplaintPage5(documentName: widget.documentName, dateTimeLocation: widget.dateTimeLocation, badges: widget.badges, witnesses: _witnesses)));
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
