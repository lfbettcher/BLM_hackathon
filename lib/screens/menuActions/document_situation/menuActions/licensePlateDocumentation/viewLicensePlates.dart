import 'package:blmhackathon/models/licensePlate.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/licensePlateDocumentation/addLicensePlate.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/licensePlateDocumentation/licenseCard.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/policeBadgeDocumentation/addPoliceBadge.dart';
///File description: View police badges page
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/models/policeBadge.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/policeBadgeDocumentation/badgeCard.dart';
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
              ),

              floatingActionButton: FloatingActionButton.extended(
                label: Row(children: <Widget>[
                  Icon(Icons.add, color: color3),
                  SizedBox(width: 10),
                  Text("Add License Plate", style: TextStyle(fontSize: defaultFontSize, color: color3)),
                ],),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => AddLicensePlate()));
                },
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
