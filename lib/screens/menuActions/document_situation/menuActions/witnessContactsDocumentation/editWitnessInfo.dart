///File description: Page to edit info for an individual witness
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/witness.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/document_situation.dart';

class EditWitnessInfo extends StatefulWidget {
  final Witness witness;
  final String userId;
  EditWitnessInfo({this.witness, this.userId});

  @override
  _EditWitnessInfoState createState() => _EditWitnessInfoState();
}

class _EditWitnessInfoState extends State<EditWitnessInfo> {
  final _formKey = GlobalKey<FormState>();
  String newWitnessName = '';
  String newWitnessEmail = '';
  String newWitnessPhone = '';
  String newWitnessAltPhone = '';

  ///pop up window that comes up for confirmation when info has been successfully submitted
  confirmationDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
            height: 100,
            width: 100,
            child: Column(
              children: <Widget>[
                Text("Your witness document has been successfully updated."),
                SizedBox(height: 10),
                GestureDetector(
                    child: FlatButton(color: color5, child: Text("OK", style: TextStyle(color: color3)),
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
                  resizeToAvoidBottomInset: true,

                  ///menu slider window
                  drawer: NavigationMenu(),

                  ///app bar
                  appBar: new AppBar(
                      title: new Text("Edit Witness Contact Information")
                  ),

                  ///body
                  body: Center(
                      child: SafeArea(
                          child: Container(
                              margin: const EdgeInsets.all(20.0),
                              child: ListView(
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
                                          initialValue: widget.witness.name,
                                          decoration: textInputDecoration.copyWith(hintText: "Name"),
                                          validator: (val) => val.isEmpty ? "Enter the witness's name" : null, //if it is not valid, return a string, otherwise return null
                                          onChanged: (val){
                                            setState(() =>newWitnessName = val);
                                          },
                                        ),
                                        SizedBox(height: 20.0),
                                        ///email field
                                        TextFormField(
                                          initialValue: widget.witness.email,
                                          decoration: textInputDecoration.copyWith(hintText: "Email"),
                                          validator: (val) => val.isEmpty ? "Enter the witness's email" : null,
                                          onChanged: (val){
                                            setState(() =>newWitnessEmail = val);
                                          },
                                        ),
                                        SizedBox(height: 20.0),
                                        ///phone field
                                        TextFormField(
                                          initialValue: widget.witness.phone,
                                          decoration: textInputDecoration.copyWith(hintText: "Phone"),
                                          validator: (val) => val.isEmpty ? "Enter the witness's phone" : null,
                                          onChanged: (val){
                                            setState(() =>newWitnessPhone = val);
                                          },
                                        ),
                                        SizedBox(height: 20.0),
                                        ///alt phone field
                                        TextFormField(
                                          initialValue: widget.witness.altPhone,
                                          decoration: textInputDecoration.copyWith(hintText: "Alternate Phone"),
                                          onChanged: (val){
                                            setState(() =>newWitnessAltPhone = val);
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
                                                await DatabaseService(uid: user.uid).updateWitness(widget.witness, newWitnessName, newWitnessEmail, newWitnessPhone, newWitnessAltPhone);
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