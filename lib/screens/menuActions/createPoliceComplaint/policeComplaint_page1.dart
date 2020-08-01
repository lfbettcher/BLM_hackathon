///File description: Police complaint page 1. This page takes in the name of the document.
import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/progressBar.dart';
import 'package:blmhackathon/screens/menuActions/createPoliceComplaint/policeComplaint_page2.dart';

class PoliceComplaintPage1 extends StatefulWidget {
  @override
  _PoliceComplaintPage1State createState() => _PoliceComplaintPage1State();
}

class _PoliceComplaintPage1State extends State<PoliceComplaintPage1> {
  final _formKey = GlobalKey<FormState>();
  String documentName = '';

  @override
  Widget build(BuildContext context) {
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
                          validator: (val) => val.isEmpty || val == "" ? "Enter a document name" : null,
                          onChanged: (val){
                            setState(() => documentName = val);
                          },
                        ),
                        SizedBox(height: 30),
                      ],
                    )
                  ),
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
                      builder: (context) => PoliceComplaintPage2(documentName: documentName,)));
            },
          ),
        );
      }
}
