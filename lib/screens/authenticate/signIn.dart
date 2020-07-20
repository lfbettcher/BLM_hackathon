///File description: Sign in page
import 'package:blmhackathon/services/auth.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false; //if this variable is true, we will show the loading widget
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: SafeArea(
            child: Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100.0),
                    Text(title, style: titleDecoration),
                    SizedBox(height: 30),
                    Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          SizedBox(height: 20.0),
                          //email field
                          TextFormField(
                            decoration: textInputDecoration.copyWith(hintText: "Email"),
                            validator: (val) => val.isEmpty ? "Enter an email" : null, //if it is not valid, return a string, otherwise return null
                            onChanged: (val){
                              setState(() =>email = val);
                            },
                          ),
                          //password field
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(hintText: "Password"),
                            validator: (val) => val.length < 6 ? "Enter a password 6+ chars long" : null, //if it is not valid, return a string, otherwise return null
                            obscureText: true, //this is so you can't see what is being typed to password
                            onChanged: (val){
                              setState(() =>password = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          GestureDetector(
                              child: Text("Don't have an account? Register here."),
                              onTap:(){
                                widget.toggleView();
                              },
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                            color: color2,
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: color3),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) { //if this is true, then we have a valid form
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                if (result == null){
                                  setState(() {
                                    loading = false;
                                  });
                                  setState(() => error = "error signing in");
                                }
                              }
                            },
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                            color: color5,
                            child: Text(
                                'Use Anonymously',
                                 style: TextStyle(color: color3),
                            ),
                            onPressed: () async {
                              dynamic result = await _auth.signInAnon();
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                });
                                setState(() => error = "error signing in");
                              }
                            },
                          )
                        ],
                      )
                    ),
                  ],
                )
             ),
          ),
        )
    );
  }
}
