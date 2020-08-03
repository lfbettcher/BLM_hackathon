///File description: Police complaint page 10. This page creates the pdf and allows the user to download it.
import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/navigationMenu.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/progressBar.dart';
import 'package:blmhackathon/models/policeBadge.dart';
import 'package:blmhackathon/models/witness.dart';
import 'package:blmhackathon/models/dateTimeLocationStamp.dart';
import 'package:blmhackathon/models/licensePlate.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'pdfPreviewScreen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:blmhackathon/shared/loading.dart';

class PoliceComplaintPage9 extends StatefulWidget {
  final DateTimeLocationStamp dateTimeLocation;
  final List<Badge> badges;
  final List<Witness> witnesses;
  final List<License> licenses;
  final List<String> complaintReasons;
  final String documentName;
  final String details;
  final String userEmail;
  final String userPhone;
  final String userAltPhone;
  final String userFullName;
  PoliceComplaintPage9({this.documentName, this.dateTimeLocation, this.badges, this.witnesses, this.licenses, this.complaintReasons, this.details, this.userEmail, this.userPhone, this.userAltPhone, this.userFullName});

  @override
  _PoliceComplaintPage9State createState() => _PoliceComplaintPage9State();
}

class _PoliceComplaintPage9State extends State<PoliceComplaintPage9> {
  final pdf = pw.Document();
  String todayDate = '';
  String dateTimeLocationInfo = '';
  String witnessInfo = '';
  String policeBadgeInfo = '';
  String complaintReasons = '';
  String complaintDetails = '';
  String licenses = '';
  String downloadURL = '';
  String localStoragePath = '';

  getTodaysDate(){
    final now = new DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    setState(() {
      todayDate = formatter;
    });
  }

  getDateTimeLocation(){
    if (widget.dateTimeLocation != null) {
      String result = '';
      //result = result + 'Date of incident: ${widget.dateTimeLocation.date} \n';
      result = result + 'Time: ${widget.dateTimeLocation.time} \n';
      result = result +
          'Location: LAT ${widget.dateTimeLocation.latitude}, LON ${widget
              .dateTimeLocation.longitude}\n';
      setState(() {
        dateTimeLocationInfo = result;
      });
    }
  }

  getWitnesses(){
    String result = '\n';
    List<Witness> witnesses = widget.witnesses;
    for (int i = 0; i<witnesses.length; i++){
      result = result + "Name: ${witnesses[i].name} \n";
      result = result +  "Email: ${witnesses[i].email} \n";
      result = result + "Phone: ${witnesses[i].phone} \n";
      result = result + "Alternate Phone: ${witnesses[i].altPhone} \n\n";
    }
    setState(() {
      witnessInfo = result;
    });
  }

  getPoliceBadgeInfo(){
    String result = '';
    List<Badge> badges = widget.badges;
    for (int i = 0; i<badges.length; i++){
      result = result + "Officer #${badges[i].badgeNumber}    ";
    }
    setState(() {
      policeBadgeInfo = result;
    });
  }

  getLicenses(){
    String result = '';
    List<License> licensePlates = widget.licenses;
    for (int i=0; i<licensePlates.length; i++){
      result = result + "${licensePlates[i].licenseNumber}    ";
    }
    setState(() {
      licenses = result;
    });
  }

  getComplaintReasons(){
    String result = '';
    List<String> complaints = widget.complaintReasons;
    for (int i=0; i<complaints.length; i++)
      {
        result = result + complaints[i] + '    ';
      }
    setState(() {
      complaintReasons = result;
    });
  }

  getComplaintDetails(){
    setState(() {
      complaintDetails = widget.details + '\n';
    });
  }

  createNewPdf() async {
    writeOnPdf();
    await savePdf();
  }

  writeOnPdf(){
    ///pdf based on: https://rlc.org.au/sites/default/files/attachments/police_complaint_template_printable_0.pdf
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context){
          return <pw.Widget>[
            pw.Header(
              level: 0,
              child: pw.Text("Police Complaint", textScaleFactor: 2)
            ),
            pw.Paragraph(
              text: "Date: ${todayDate}\n"
            ),
            pw.Paragraph(
                text: "Dear Sir/Madam,\n"
            ),
            pw.Paragraph(
                text: "This is a formal complaint relating to the conduct of members of your police force.\n"
            ),
            pw.Header(
              level: 2,
              text: "Factual Background: "
            ),
            pw.Paragraph(
                text: dateTimeLocationInfo
            ),
            pw.Paragraph(
              text: "Witnesses: ${witnessInfo}"
            ),
            pw.Paragraph(
              text: "Police officers involved: ${policeBadgeInfo}"
            ),
            pw.Paragraph(
              text: "License plates of interest: ${licenses}"
            ),
            pw.Header(
                level: 2,
                text: "Complaint: "
            ),
            pw.Paragraph(
              text: "Reasons for complaint: \n${complaintReasons}"
            ),
            pw.Paragraph(
              text: "Details: \n${complaintDetails}"
            ),
            pw.Header(
              level: 2,
              text: "Next Steps: "
            ),
            pw.Paragraph(
              text: "This complaint is made on the basis that the police officers engaged in either police misconduct or maladministration as defined by law enforement conduct. I request that this complaint is subject to an evidence-based investigation."
            ),
            pw.Paragraph(
              text: "I have attached my contact information below. Please contact me if you require any further information."
            ),
            pw.Paragraph(
              text: "Email: ${widget.userEmail} \nPhone: ${widget.userPhone} \nAlternate Phone: ${widget.userAltPhone}"
            ),
            pw.Paragraph(
              text: "Yours faithfully, \n ${widget.userFullName}"
            ),
          ];
        }
      )
    );
  }

  Future savePdf() async {
      /// save to local app storage
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String documentPath = documentDirectory.path;
      File file = File("$documentPath/example.pdf");
      String filePath = "$documentPath/example.pdf";
      file.writeAsBytesSync(pdf.save());

      /// save to firebase storage
      final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("$documentPath/example.pdf");
      final StorageUploadTask task = firebaseStorageRef.putFile(file);
      String url = await firebaseStorageRef.getDownloadURL();

      setState(() {
        downloadURL = url;
        localStoragePath = filePath;
      });
  }

  @override
  void initState() {
    super.initState();
    getTodaysDate();
    getDateTimeLocation();
    getWitnesses();
    getPoliceBadgeInfo();
    getComplaintReasons();
    getComplaintDetails();
    getLicenses();
    createNewPdf();
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
        return
          Scaffold(
            resizeToAvoidBottomInset: true,

            ///menu slider window
            drawer: NavigationMenu(),

            ///app bar
            appBar: new AppBar(
                title: new Text("Create a new police complaint")
            ),

            ///body
            body: Center(
                child: Container(
                    width: 300,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 30),
                        ProgressBar(percent: 1.0),
                        SizedBox(height: 50),
                        ButtonTheme(
                          minWidth: 200.0,
                          height: 100.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: <Widget>[
                              Text("      Preview document", style: TextStyle(color: color3, fontSize: defaultFontSize)),
                              SizedBox(width: 10),
                              Icon(Icons.picture_as_pdf, color: color3)
                            ],),
                            color: color5,
                            onPressed: () async {
                              Directory documentDirectory = await getApplicationDocumentsDirectory();
                              String documentPath = documentDirectory.path;
                              String fullPath = "$localStoragePath";
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => PdfPreviewScreen(path: fullPath)
                              ));
                            },
                          ),
                        ),
                        SizedBox(height: 50),
                        ButtonTheme(
                          minWidth: 200.0,
                          height: 100.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: <Widget>[
                                Text("      Download document", style: TextStyle(color: color3, fontSize: defaultFontSize)),
                                Icon(Icons.file_download, color: color3)
                              ],
                            ),
                            color: color6,
                            onPressed: () async {
                              final status = await Permission.storage.request();
                              if(status.isGranted){
                                final externalDir = await getExternalStorageDirectory();
                                final id = await FlutterDownloader.enqueue(
                                    url: downloadURL,
                                    savedDir: externalDir.path,
                                    fileName: "${widget.documentName}",
                                    showNotification: true,
                                    openFileFromNotification: true
                                );
                              }
                              else{
                                print("Permission denied");
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    )
                )
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Row(children: <Widget>[
                Text("Done", style: TextStyle(fontSize: defaultFontSize, color: color3)),
                SizedBox(width: 10),
                Icon(Icons.done, color: color3)
              ],),
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
