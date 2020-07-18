///File description: View witness contacts page
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/models/witness.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/witnessContactsDocumentation/witnessCard.dart';

class ViewWitnessContacts extends StatefulWidget {
  @override
  _ViewWitnessContactsState createState() => _ViewWitnessContactsState();
}

class _ViewWitnessContactsState extends State<ViewWitnessContacts> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return StreamBuilder<List<Witness>>(
        stream: DatabaseService(uid: user.uid).witnessData,

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Witness> witnesses = snapshot.data;
            print(witnesses.length);
            return Scaffold(
              resizeToAvoidBottomPadding: false,

              ///menu slider window
              drawer: NavigationMenu(),

              ///app bar
              appBar: new AppBar(
                  title: new Text("Witness Contacts")
              ),

              ///body
              body: Center(
                child: Container(
                  child: Column(children: <Widget>[
                    SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: witnesses.length,
                          itemBuilder: (context, index){
                            return WitnessCard(witness: witnesses[index], userId: user.uid);
                          }
                      ),
                    ),
                  ],)
                ),
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
