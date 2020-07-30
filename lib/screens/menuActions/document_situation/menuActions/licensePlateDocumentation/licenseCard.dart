///File description: Card layout for an individual license plate
import 'package:flutter/material.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/models/licensePlate.dart';

class LicenseCard extends StatefulWidget {
  final License license;
  final String userId;

  LicenseCard({this.license, this.userId});
  @override
  _LicenseCardState createState() => _LicenseCardState();
}

class _LicenseCardState extends State<LicenseCard> {

  @override
  Widget build(BuildContext context) {

    ///pop up box to confirm deletion
    confirmDeleteDialog(BuildContext context){
      return showDialog(context: context, builder: (context){
        return AlertDialog(
            title: Text("Are you sure you want to delete this license plate entry?"),
            content: Row(children: <Widget>[
              SizedBox(height: 25),
              RaisedButton(
                  color: color2,
                  onPressed: () async {
                    await DatabaseService(uid: widget.userId).deleteLicense(widget.license.licenseId);
                    Navigator.of(context).pop();
                  },
                  textColor: color3,
                  child: Text("Yes")),
              SizedBox(width: 55),
              RaisedButton(
                  color: color6,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textColor: color3,
                  child: Text("No")),
            ],)
        );
      }
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                      title: Text("#${widget.license.licenseNumber}",
                        style: TextStyle(fontSize: defaultFontSize),
                      )),
                  FlatButton(
                    textColor: color6,
                    child: Row(children: <Widget>[
                      Icon(Icons.delete),
                      SizedBox(width: 5),
                      Text("Delete", style: TextStyle(fontSize: 15))
                    ],),
                    onPressed: (){
                      confirmDeleteDialog(context);
                    },
                  ),
                ],
              )
          )
      ),
    );
  }
}
