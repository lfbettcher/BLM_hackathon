///File description: Wrapper determines the state of the user
///aka whether if someone is logged in or not
import 'package:blmhackathon/screens/authenticate/authenticate.dart';
import 'package:blmhackathon/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blmhackathon/models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null){ //nobody is logged in
      return Authenticate();
    }
    else{ //someone is logged in
      return Home();
    }
  }
}
