///File description: root of application
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/user.dart';
import 'package:blmhackathon/services/auth.dart';
import 'package:blmhackathon/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value( //User is the type of data object that is going down the stream
      value: AuthService().user,//specify what stream we want to listen to and what data we expect to get back
      child: MaterialApp(
          home: Wrapper()
      ),
    );
  }
}

