///File description: Police complaint page 2. This page takes in the date/time of the incident.
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/progressBar.dart';
import 'package:blmhackathon/models/dateTimeLocationStamp.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/helperSelectionChips/selectDateTimeLocationWidget.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/policeComplaint_page3.dart';

class PoliceComplaintPage2 extends StatefulWidget {
  final String documentName;
  PoliceComplaintPage2({this.documentName});

  @override
  _PoliceComplaintPage2State createState() => _PoliceComplaintPage2State();
}

class _PoliceComplaintPage2State extends State<PoliceComplaintPage2> {
  DateTimeLocationStamp selectedStamp;

  void toggleSelect(DateTimeLocationStamp stamp){
    setState(() {
      selectedStamp = stamp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return StreamBuilder<List<DateTimeLocationStamp>>(
        stream: DatabaseService(uid: user.uid).dateTimeLocationData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DateTimeLocationStamp> dateTimeLocationStamps = snapshot.data;

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
                            ProgressBar(percent: 0.2),
                            SizedBox(height: 30),
                            Text("When and where did this incident occur? ", style: TextStyle(fontSize: defaultFontSize)),
                            SizedBox(height: 30),
                            Expanded(
                                  child:
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: dateTimeLocationStamps.length,
                                        itemBuilder: (context, index){
                                          return Column(
                                            children: <Widget>[
                                              //SizedBox(height: 10),
                                              SelectDateTimeLocationWidget(dateTimeLocationStamp: dateTimeLocationStamps[index], toggleSelect: toggleSelect)
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
                          builder: (context) => PoliceComplaintPage3(dateTimeLocation: selectedStamp, documentName: widget.documentName)));
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
