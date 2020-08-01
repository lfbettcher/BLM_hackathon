///File description: Police complaint page 5. This page lets users select the reasons for complaint.
import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/progressBar.dart';
import 'package:blmhackathon/models/policeBadge.dart';
import 'package:blmhackathon/models/witness.dart';
import 'package:blmhackathon/models/dateTimeLocationStamp.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/helperSelectionChips/selectComplaintReasonsWidget.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/policeComplaint_page7.dart';

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
  List<String> _complaintReasons = <String>[];

  void toggleSelect(String complaint){
    setState(() {
      if (_complaintReasons.contains(complaint)){
        _complaintReasons.removeWhere((String removeComplaint){
          return complaint == removeComplaint;
        });
      }
      else{
        _complaintReasons.add(complaint);
      }
    });
  }

  var complaints = [
    "neglect of duty",
    "poor service",
    "misuse of confidential information",
    "unauthorized search",
    "arrest or detention",
    "use of force",
    "rude or disrespectful behaviour",
    "discrimination",
    "other"
  ];

  @override
  Widget build(BuildContext context) {
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
                          ProgressBar(percent: 0.70),
                          SizedBox(height: 30),
                          Text("Select your reasons(s) for complaint: ", style: TextStyle(fontSize: defaultFontSize)),
                          SizedBox(height: 30),
                          Expanded(
                            child:
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: complaints.length,
                                itemBuilder: (context, index){
                                  return Column(
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      SelectComplaintWidget(complaint: complaints[index], toggleSelect: toggleSelect)
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
                          builder: (context) => PoliceComplaintPage6(documentName: widget.documentName, dateTimeLocation: widget.dateTimeLocation, badges: widget.badges, witnesses: widget.witnesses, complaintReasons: _complaintReasons)));
                },
              ),
            );

  }
}
