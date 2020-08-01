///File description: Police complaint page 6. This page lets users provide details of the incident.
import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/progressBar.dart';
import 'package:blmhackathon/models/policeBadge.dart';
import 'package:blmhackathon/models/witness.dart';
import 'package:blmhackathon/models/dateTimeLocationStamp.dart';
import 'package:blmhackathon/models/licensePlate.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/policeComplaint_page8.dart';

class PoliceComplaintPage7 extends StatefulWidget {
  final DateTimeLocationStamp dateTimeLocation;
  final List<Badge> badges;
  final List<Witness> witnesses;
  final List<License> licenses;
  final List<String> complaintReasons;
  final String documentName;
  PoliceComplaintPage7({this.documentName, this.dateTimeLocation, this.badges, this.witnesses, this.licenses, this.complaintReasons});

  @override
  _PoliceComplaintPage7State createState() => _PoliceComplaintPage7State();
}

class _PoliceComplaintPage7State extends State<PoliceComplaintPage7> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode;
  String details = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  ProgressBar(percent: 0.7),
                  SizedBox(height: 30),
                  Text("Provide details of the incident. ", style: TextStyle(fontSize: defaultFontSize)),
                  SizedBox(height: 10),
                  Text("Be as specific as possible! ", style: TextStyle(fontSize: defaultFontSize)),
                  SizedBox(height: 30),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            focusNode: _focusNode,
                            maxLines: null,
                            autofocus:false ,
                            textInputAction: TextInputAction.done,
                            onChanged: (val){
                              setState(() {
                                details = val;
                              });
                            },
                            onEditingComplete: () {
                              _focusNode.unfocus();
                            },
                          ),
                        ],
                      )
                  )
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
                          builder: (context) => PoliceComplaintPage8(documentName: widget.documentName, dateTimeLocation: widget.dateTimeLocation, badges: widget.badges, witnesses: widget.witnesses, licenses: widget.licenses, complaintReasons: widget.complaintReasons, details: details)));
        },
      ),
    );
  }
}
