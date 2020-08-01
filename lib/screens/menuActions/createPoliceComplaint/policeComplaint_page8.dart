///File description: Police complaint page 8. This page lets users provide contact information.
import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/progressBar.dart';
import 'package:blmhackathon/models/policeBadge.dart';
import 'package:blmhackathon/models/witness.dart';
import 'package:blmhackathon/models/dateTimeLocationStamp.dart';
import 'package:blmhackathon/models/licensePlate.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/policeComplaint_page9.dart';

class PoliceComplaintPage8 extends StatefulWidget {
  final DateTimeLocationStamp dateTimeLocation;
  final List<Badge> badges;
  final List<Witness> witnesses;
  final List<License> licenses;
  final List<String> complaintReasons;
  final String details;
  final String documentName;
  PoliceComplaintPage8({this.documentName, this.dateTimeLocation, this.badges, this.witnesses, this.licenses, this.complaintReasons, this.details});

  @override
  _PoliceComplaintPage8State createState() => _PoliceComplaintPage8State();
}

class _PoliceComplaintPage8State extends State<PoliceComplaintPage8> {
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String email = '';
  String phone = '';
  String altPhone = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Scaffold(
              resizeToAvoidBottomInset: true,

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
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 30),
                          ProgressBar(percent: 0.8),
                          SizedBox(height: 30),
                          Text("Provide your contact information: ", style: TextStyle(fontSize: defaultFontSize)),
                          SizedBox(height: 30),

                          Form(
                              key: _formKey,
                              child: Column(children: <Widget>[
                                SizedBox(height: 20.0),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(hintText: "Full name"),
                                  validator: (val) => val.isEmpty ? "Enter your full name" : null,
                                  onChanged: (val){
                                    fullName = val;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                                  validator: (val) => val.isEmpty ? "Enter an email" : null,
                                  onChanged: (val){
                                    email = val;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(hintText: "Phone"),
                                  validator: (val) => val.length < 6 ? "Enter your primary phone number" : null,
                                  onChanged: (val){
                                    phone = val;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(hintText: "Alternate Phone"),
                                  onChanged: (val){
                                    altPhone = val;
                                  },
                                ),
                                SizedBox(height: 20.0),
                              ],
                              )
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
                  if (_formKey.currentState.validate())
                  {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PoliceComplaintPage9(documentName: widget.documentName, dateTimeLocation: widget.dateTimeLocation, badges: widget.badges, witnesses: widget.witnesses, licenses: widget.licenses, complaintReasons: widget.complaintReasons, details: widget.details, userEmail: email, userPhone: phone, userAltPhone: altPhone, userFullName: fullName)));
                    }
                  }
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
