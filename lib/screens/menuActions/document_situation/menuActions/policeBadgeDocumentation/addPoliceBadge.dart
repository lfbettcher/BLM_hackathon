///File description: Add a police badge page
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/document_situation.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/services.dart';

class AddPoliceBadge extends StatefulWidget {
  @override
  _AddPoliceBadgeState createState() => _AddPoliceBadgeState();
}

class _AddPoliceBadgeState extends State<AddPoliceBadge> {
  File pickedImage;
  bool isImageLoaded = false;
  String _policeBadge;
  final _formKey = GlobalKey<FormState>();

  ///pop up window that comes up for confirmation when info has been successfully submitted
  confirmationDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
            height: 100,
            width: 100,
            child: Column(
              children: <Widget>[
                Text("The police ID has been successfully added."),
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
  ///Pick an image from the phone gallery
  Future pickImageGallery() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
    readText();
  }

  ///Open camera to take a picture
  Future pickImageCamera() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
    readText();
  }

  ///Attempts to read text from the image
  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    String badgeNumber = '';
    for (TextBlock block in readText.blocks){
      for (TextLine line in block.lines){
        for (TextElement word in line.elements){
          if (isNumeric(word.text)){
            badgeNumber += word.text;
          }
          print(word.text);
        }
      }
    }
    setState(() {
      if (badgeNumber != ''){
        _policeBadge = badgeNumber;
      }
      else{
        _policeBadge = "UNKNOWN";
      }
    });
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

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
                resizeToAvoidBottomPadding: false,

                ///menu slider window
                drawer: NavigationMenu(),

                ///app bar
                appBar: new AppBar(
                    title: new Text("Add Police Badge")
                ),

                ///body
                body: Center(
                  child: Container(
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30),
                          Text("Pick an image: ", style: TextStyle(color: color1, fontSize: defaultFontSize)),
                          SizedBox(height: 30),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ButtonBar(children: <Widget>[
                                  RaisedButton(
                                    child: Row(
                                      children: <Widget>[
                                        Text("Camera"),
                                        SizedBox(width: 10),
                                        Icon(Icons.camera)
                                      ],
                                    ),
                                    onPressed: (){
                                      pickImageCamera();
                                    },
                                  ),
                                  RaisedButton(
                                    child: Row(
                                      children: <Widget>[
                                        Text("Gallery"),
                                        SizedBox(width: 10),
                                        Icon(Icons.photo_album)
                                      ],
                                    ),
                                    onPressed: (){
                                      pickImageGallery();
                                    },
                                  ),
                                ],),
                              ]),
                          isImageLoaded ? Container(
                              child: Text("Badge # ${_policeBadge}", style: TextStyle(color: color1, fontSize: defaultFontSize))
                          ) : Container(),

                          SizedBox(height: 30),
                          Text("OR", style: TextStyle(color: color1, fontSize: defaultFontSize)),
                          SizedBox(height: 30),
                          Text("Manually type in the badge number:", style: TextStyle(color: color1, fontSize: defaultFontSize)),
                          SizedBox(height: 30),
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              //valueLi
                              decoration: textInputDecoration.copyWith(hintText: "####"),
                              keyboardType: TextInputType.number, style: TextStyle(fontSize: 20, fontFamily: "Courier", fontWeight: FontWeight.bold),
                              maxLength: 4,
                              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                              onChanged: (val) {
                                setState(() {
                                  _policeBadge = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            color: color5,
                            child:  Center(child: Text("Enter", style: TextStyle(fontSize: defaultFontSize, color: color3))),
                            onPressed: () async {
                              if (_formKey.currentState.validate()){
                                await DatabaseService(uid: user.uid).createNewPoliceBadgeDocument(_policeBadge);
                                confirmationDialog(context);
                              }
                            },
                          ),
                        ],
                      )
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

