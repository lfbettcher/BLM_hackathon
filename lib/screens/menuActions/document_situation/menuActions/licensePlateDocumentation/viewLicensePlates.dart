///File description: View license plates page
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/models/licensePlate.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/licensePlateDocumentation/licenseCard.dart';
import 'package:blmhackathon/shared/constants.dart';

class ViewLicensePlates extends StatefulWidget {
  @override
  _ViewLicensePlatesState createState() => _ViewLicensePlatesState();
}

class _ViewLicensePlatesState extends State<ViewLicensePlates> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    return StreamBuilder<List<License>>(
        stream: DatabaseService(uid: user.uid).licenseData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<License> licenses = snapshot.data;
            return Scaffold(
                resizeToAvoidBottomPadding: false,

                ///menu slider window
                drawer: NavigationMenu(),

                ///app bar
                appBar: new AppBar(
                    title: new Text("License Plates")
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
                              itemCount: licenses.length,
                              itemBuilder: (context, index){
                                return LicenseCard(license: licenses[index], userId: user.uid);
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

