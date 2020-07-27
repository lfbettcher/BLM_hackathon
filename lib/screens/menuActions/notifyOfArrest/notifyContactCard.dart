///File description: Card layout for an individual witness. Send a text message to this witness when it is tapped.
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/contact.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:blmhackathon/screens/home/home.dart';
import 'package:blmhackathon/shared/loading.dart';

class NotifyContactCard extends StatefulWidget {
  final Contact emerContact;

  NotifyContactCard({this.emerContact});
  @override
  _NotifyContactCardState createState() => _NotifyContactCardState();
}

class _NotifyContactCardState extends State<NotifyContactCard> {
  final _formKey = GlobalKey<FormState>(); //form key for editing the witness's info
  String senderName = '';
  String latitude = '';
  String longitude = '';

  void _getCurrentLocation() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position != null){
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      });
    }
  }

  /// need to wrap _getCurrentLocation() into a synchronous function to make it synchronous
  /// otherwise the lat/lon values won't set in time when we send over the text
  void _getLocationValues(){
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    ///pop up box to confirm that SMS has been sent, redirect screen page
    okSendDialog(BuildContext context){
      return showDialog(context: context, builder: (context){
        return AlertDialog(
            title: Text("Notification sent to ${widget.emerContact.name}'s primary number at ${widget.emerContact.phone}"),
            content: Container(
              height: 100,
              child: GestureDetector(
                child: Column(children: <Widget>[
                  Icon(Icons.check_circle, size: 50, color: color2),
                  SizedBox(height: 10),
                  Text("OK")
                ],),
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Home()));
                },
              ),
            )
        );
       }
      );
     }

    ///pop up box to confirm send SMS
    confirmSendDialog(BuildContext context){
      return showDialog(context: context, builder: (context){
        return AlertDialog(
            title: Text("Confirm notification to ${widget.emerContact.name}"),
            content: Row(children: <Widget>[
              SizedBox(width: 25),
              RaisedButton(
                  color: color2,
                  ///send the message
                  onPressed: () async {
                    /// build message
                    _getLocationValues();
                    String message = '''Your contact ''' + senderName + ''' has been arrested and may need your help. Their last location was latitude ${latitude} and longitude ${longitude}.''';

                    ///twilio setup
                    TwilioFlutter twilioFlutter = TwilioFlutter(
                        accountSid : 'xxxxxxxxxxxxxxxxx',
                        authToken : 'xxxxxxxxxxxxxxxxxxxxxxxx',
                        twilioNumber : 'xxxxxxxxxxxxx'
                    );

                    /*
                    /// send the message
                    twilioFlutter.sendSMS(
                        toNumber : '${widget.emerContact.phone}',
                        messageBody : message).then((value){
                      okSendDialog(context);
                    });
                    */
                  },
                  textColor: Colors.white,
                  child: Text("Send")),
              SizedBox(width: 55),
              RaisedButton(
                  color: color6,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textColor: Colors.white,
                  child: Text("Cancel", style: TextStyle(fontSize: defaultFontSize))),
              SizedBox(height: 55),
            ],)
        );
      }
    );
  }


    ///the actual card that is being returned
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
    builder: (context, snapshot){
        if (snapshot.hasData){
        UserData userData = snapshot.data;
          return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                  child: GestureDetector(
                    child: Container(
                      child: ListTile(
                        title: Center(child: Text(widget.emerContact.name, style: TextStyle(fontSize: defaultFontSize))),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        senderName = userData.name;
                      });
                      confirmSendDialog(context);
                    },
                  )
              ));
        }
        else{
          return Loading();
        }
      }
    );
  }
}