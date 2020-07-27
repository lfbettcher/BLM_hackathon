import 'package:blmhackathon/screens/menuActions/document_situation/document_situation.dart';
///File description: Add and view time stamps
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class DateTimeLocationStamp extends StatefulWidget {
  @override
  _DateTimeLocationStampState createState() => _DateTimeLocationStampState();
}

class _DateTimeLocationStampState extends State<DateTimeLocationStamp> {
  String latitude = '';
  String longitude = '';
  bool showLocationResults = false;
  bool showErrorMessage = false;

  void _getCurrentLocation() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position != null){
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        setState(() {
          showLocationResults = true;
          showErrorMessage = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk:mm:ss').format(now);
    String formattedDate = DateFormat('EEE d MMM').format(now);

    ///pop up window that comes up for confirmation when info has been successfully submitted
    confirmationDialog(BuildContext context){
      return showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Container(
              height: 100,
              width: 100,
              child: Column(
                children: <Widget>[
                  Text("The date/time/location has been successfully recorded."),
                  SizedBox(height: 10),
                  GestureDetector(
                      child: FlatButton(color: color5, child: Text("OK", style: TextStyle(color: color4)),
                        onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) => new DocumentSituation()));
                        },
                      )
                  )
                ],
              )),
        );
      });
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
                  title: new Text("Date/Time Stamps")
              ),

              ///body
              ///to be implemented
              body: Center(
                child: Container(
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Row(children: <Widget>[
                        Icon(Icons.timer),
                        SizedBox(width: 10),
                        Text("Current time: ${formattedTime}", style: TextStyle(fontSize: defaultFontSize)),
                      ],),
                      SizedBox(height: 30),
                      Row(children: <Widget>[
                        Icon(Icons.calendar_today),
                        SizedBox(width: 10),
                        Text("Current time: ${formattedDate}", style: TextStyle(fontSize: defaultFontSize))
                      ],),
                      SizedBox(height: 30),
                      Visibility(
                        child: Row(children: <Widget>[
                          Icon(Icons.map),
                          SizedBox(width: 10),
                          Text("Latitude: ${latitude}   ", style: TextStyle(fontSize: defaultFontSize)),
                        ],),
                        visible: showLocationResults,
                      ),
                      SizedBox(height: 15),
                      Visibility(
                        child: Row(children: <Widget>[
                          SizedBox(width: 10),
                          Text("      Longitude: ${longitude}", style: TextStyle(fontSize: defaultFontSize)),
                        ],),
                        visible: showLocationResults,
                      ),
                      Visibility(
                        child: Row(children: <Widget>[
                          Icon(Icons.map),
                          SizedBox(width: 10),
                          GestureDetector(
                              child: Text("Tap to get location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: defaultFontSize, color: color6)),
                            onTap: (){
                              _getCurrentLocation();
                            },
                          )
                        ],),
                        visible: !showLocationResults,
                      ),
                      SizedBox(height: 40),
                      RaisedButton(
                        color: color5,
                        child:  Center(child: Text("Enter", style: TextStyle(fontSize: defaultFontSize, color: color3))),
                        onPressed: () async {
                          if (latitude == '' && longitude == ''){
                            setState(() {
                              showErrorMessage = true;
                            });
                          }
                          else {
                            await DatabaseService(uid: user.uid)
                                .createNewDateTimeLocationStampDocument(
                                formattedDate, formattedTime, latitude,
                                longitude);
                            setState(() {
                              showErrorMessage = false;
                            });
                            confirmationDialog(context);
                          }
                        },
                      ),
                      Visibility(
                          child: Text("You must enable location services.", style: TextStyle(fontSize: defaultFontSize, color: color6)),
                          visible: showErrorMessage,
                      )
                    ],
                  )
                )
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


