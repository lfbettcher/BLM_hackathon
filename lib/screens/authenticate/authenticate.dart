///File description: Toggle authentication
import 'package:flutter/material.dart';
import 'package:blmhackathon/screens/authenticate/register.dart';
import 'package:blmhackathon/screens/authenticate/signIn.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleViewMethod(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return SignIn(toggleView: toggleViewMethod);
    }
    else{
      return Register(toggleView: toggleViewMethod);
    }
  }
}
