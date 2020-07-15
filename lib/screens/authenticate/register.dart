///File description: Registration page
import 'package:blmhackathon/services/auth.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false; //if this variable is true, we will show the loading widget
  String email = '';
  String password = '';
  String name = '';
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
                        //name field
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: "Name"),
                          validator: (val) => val.isEmpty ? "Enter your name" : null,
                          onChanged: (val){
                            setState(() =>name = val);
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
                        GestureDetector(child: Text("Already have an account? Sign in here."), onTap: (){
                          widget.toggleView();
                        }),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          color: color2,
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) { //if this is true, then we have a valid form
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.registerWithEmailAndPassword(email, password, name);
                              if (result == null){
                                setState(() {
                                  loading = false;
                                });
                                setState(() => error = "please supply a valid email");
                              }
                              else{
                                print(result);
                              }
                            }
                          },
                        ),
                      ],
                      )
                  )
                ],
              )
            )
          )
        )
    );
  }
}
