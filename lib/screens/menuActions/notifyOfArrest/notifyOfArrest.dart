import 'package:blmhackathon/screens/menuActions/notifyOfArrest/notifyContactCard.dart';
import 'package:blmhackathon/shared/constants.dart';
///File description: Page to notify contact of an arrest.
///User can send an SMS with a generic message, notifying the selected contact of them being arrested.
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/models/contact.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';

class NotifyArrest extends StatefulWidget {
  @override
  _NotifyArrestState createState() => _NotifyArrestState();
}

class _NotifyArrestState extends State<NotifyArrest> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return StreamBuilder<List<Contact>>(
        stream: DatabaseService(uid: user.uid).contactData,
        builder: (context, snapshot){
          if (snapshot.hasData){
            List<Contact> eContacts = snapshot.data;
            return Scaffold(
              ///menu slider window
              drawer: NavigationMenu(),

              ///app bar
              appBar: new AppBar(
                  title: new Text("Notify a contact of my arrest")
              ),

              ///to be implemented
              body: Center(
                child: Container(
                    width: 300,
                    child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text("Tap a contact to notify of your arrest.", style: TextStyle(fontSize: defaultFontSize)),
                      SizedBox(height: 10),
                      Text("We will send an SMS on your behalf.", style: TextStyle(fontSize: defaultFontSize)),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: eContacts.length,
                            itemBuilder: (context, index){
                              return NotifyContactCard(emerContact: eContacts[index]);
                            }
                        ),
                      ),

                    ],
                  )
                )
              )

            );
          }
          else{
            return Loading();
          }
        }
    );
  }
}
