///File description: Police complaint page 1. This page takes in the name of the document.
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/progressBar.dart';

class PoliceComplaintPage1 extends StatefulWidget {
  @override
  _PoliceComplaintPage1State createState() => _PoliceComplaintPage1State();
}

class _PoliceComplaintPage1State extends State<PoliceComplaintPage1> {
  final _formKey = GlobalKey<FormState>();
  String documentName = '';

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
                      ProgressBar(percent: 0.1),
                      SizedBox(height: 30),
                      Text("Let's help you file a police complaint. \n First, give your document a name: ", style: TextStyle(fontSize: defaultFontSize)),
                      SizedBox(height: 30),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: textInputDecoration.copyWith(hintText: ""),
                              validator: (val) => val.isEmpty ? "Enter a document name" : null,
                              onChanged: (val){
                                setState(() => documentName = val);
                                //print("document name: ");
                                //print(documentName);
                              },
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 190),
                                SizedBox(
                                    width: 110,
                                    child:  RaisedButton(
                                      color: color5,
                                      child:  Center(
                                          child: Row(children: <Widget>[
                                            Text("Next", style: TextStyle(fontSize: defaultFontSize, color: color3)),
                                            SizedBox(width: 10),
                                            Icon(Icons.arrow_forward, color: color3)
                                          ],)
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          ///create a new document with the specified name
                                          await DatabaseService(uid: user.uid).createNewPoliceComplaint(documentName);
                                          /// route to next page
                                        }
                                      },
                                    )
                                )
                              ],
                            )
                          ],
                        )
                      ),
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
