///File description: Page to edit info for an individual emergency contact
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/contact.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/document_situation.dart';
import 'package:blmhackathon/screens/menuActions/access_emergency_contacts/access_emergency_contacts.dart';


class EditEmergencyContacts extends StatefulWidget {
  final Contact emerContact;
  final String userId;
  EditEmergencyContacts({this.emerContact, this.userId});

  @override
  _EditEmergencyContactsState createState() => _EditEmergencyContactsState();
}

class _EditEmergencyContactsState extends State<EditEmergencyContacts> {
  final _formKey = GlobalKey<FormState>();
  String newContactName = '';
  String newContactEmail = '';
  String newContactPhone = '';
  String newContactAltPhone = '';

  ///pop up window that comes up for confirmation when info has been successfully submitted
  confirmationDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
            height: 100,
            width: 100,
            child: Column(
              children: <Widget>[
                Text("Your emergency contact document has been successfully updated."),
                SizedBox(height: 10),
                GestureDetector(
                    child: FlatButton(color: color5, child: Text("OK", style: TextStyle(color: color3)),
                      onPressed: (){
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => new EmergencyContacts()));
                      },
                    )
                )
              ],
            )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return
              Scaffold(
                  resizeToAvoidBottomPadding: false,

                  ///menu slider window
                  drawer: NavigationMenu(),

                  ///app bar
                  appBar: new AppBar(
                      title: new Text("Edit Emergency Contact Information")
                  ),

                  ///body
                  body: Center(
                      child: SafeArea(
                          child: Container(
                              margin: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 30),
                                  Text("Update with changes: ", style: TextStyle(color: color1, fontSize: 18)),
                                  SizedBox(height: 30),
                                  Form(
                                      key: _formKey,
                                      child: Column(children: <Widget>[
                                        SizedBox(height: 20.0),
                                        ///witness name field
                                        TextFormField(
                                          initialValue: widget.emerContact.name,
                                          decoration: textInputDecoration.copyWith(hintText: "Name"),
                                          validator: (val) => val.isEmpty ? "Enter the emergency contact's name" : null, //if it is not valid, return a string, otherwise return null
                                          onChanged: (val){
                                            setState(() =>newContactName = val);
                                          },
                                        ),
                                        SizedBox(height: 20.0),
                                        ///email field
                                        TextFormField(
                                          initialValue: widget.emerContact.email,
                                          decoration: textInputDecoration.copyWith(hintText: "Email"),
                                          validator: (val) => val.isEmpty ? "Enter the emergency contact's email" : null,
                                          onChanged: (val){
                                            setState(() =>newContactEmail = val);
                                          },
                                        ),
                                        SizedBox(height: 20.0),
                                        ///phone field
                                        TextFormField(
                                          initialValue: widget.emerContact.phone,
                                          decoration: textInputDecoration.copyWith(hintText: "Phone"),
                                          validator: (val) => val.isEmpty ? "Enter the emergency contact's phone" : null,
                                          onChanged: (val){
                                            setState(() =>newContactPhone = val);
                                          },
                                        ),
                                        SizedBox(height: 20.0),
                                        ///alt phone field
                                        TextFormField(
                                          initialValue: widget.emerContact.altPhone,
                                          decoration: textInputDecoration.copyWith(hintText: "Alternate Phone"),
                                          onChanged: (val){
                                            setState(() =>newContactAltPhone = val);
                                          },
                                        ),
                                        SizedBox(height: 20.0),
                                        RaisedButton(
                                          color: color2,
                                          child: Text(
                                            'Submit',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState.validate()) {
                                              await DatabaseService(uid: user.uid).updateEmergencyContact(widget.emerContact, newContactName, newContactEmail, newContactPhone, newContactAltPhone);
                                              confirmationDialog(context);
                                            }
                                          },
                                        ),
                                      ],
                                      )
                                  )
                                ],
                              )
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