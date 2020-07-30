///File description: Add a witness contact page
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/document_situation.dart';

class AddWitnessContact extends StatefulWidget {
  @override
  _AddWitnessContactState createState() => _AddWitnessContactState();
}

class _AddWitnessContactState extends State<AddWitnessContact> {

  ///pop up window that comes up for confirmation when info has been successfully submitted
  confirmationDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
            height: 100,
            width: 100,
            child: Column(
            children: <Widget>[
              Text("Your witness document has been successfully added."),
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

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String witnessName = '';
  String witnessEmail = '';
  String witnessPhone = '';
  String witnessAltPhone = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
                  title: new Text("Add A Witness Contact")
              ),

              ///body
              body: Center(
                  child: SafeArea(
                      child: Container(
                          margin: const EdgeInsets.all(20.0),
                          child: ListView(
                            children: <Widget>[
                              SizedBox(height: 30),
                              Text("Fill out the witness's information: ", style: TextStyle(color: color1, fontSize: 18)),
                              SizedBox(height: 30),
                              Form(
                                  key: _formKey,
                                  child: Column(children: <Widget>[
                                    SizedBox(height: 20.0),
                                    ///witness name field
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(hintText: "Name"),
                                      validator: (val) => val.isEmpty ? "Enter the witness's name" : null, //if it is not valid, return a string, otherwise return null
                                      onChanged: (val){
                                        setState(() =>witnessName = val);
                                      },
                                    ),
                                    SizedBox(height: 20.0),
                                    ///email field
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(hintText: "Email"),
                                      validator: (val) => val.isEmpty ? "Enter the witness's email" : null,
                                      onChanged: (val){
                                        setState(() =>witnessEmail = val);
                                      },
                                    ),
                                    SizedBox(height: 20.0),
                                    ///phone field
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(hintText: "Phone"),
                                      validator: (val) => val.isEmpty ? "Enter the witness's phone" : null,
                                      onChanged: (val){
                                        setState(() =>witnessPhone = val);
                                      },
                                    ),
                                    SizedBox(height: 20.0),
                                    ///alt phone field
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(hintText: "Alternate Phone"),
                                      onChanged: (val){
                                        setState(() =>witnessAltPhone = val);
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
                                          await DatabaseService(uid: user.uid).createNewWitnessDocument(witnessName, witnessEmail, witnessPhone, witnessAltPhone);
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
