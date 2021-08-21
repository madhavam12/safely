import 'package:flutter/material.dart';
import 'package:safely/services/firebaseAuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connection_verify/connection_verify.dart';
import 'homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar({String value, Color color, int sec = 3}) {
    FocusScope.of(context).requestFocus(new FocusNode());

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color,
      duration: Duration(seconds: sec),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                Image.asset("assets/images/login.png", height: 250),
                Text(
                  "Tap below to login",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "QuickSand",
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 15),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                        top: 3.0, bottom: 3.0, left: 15.0, right: 15),
                    color: const Color(0xFF4285F4),
                    onPressed: () async {
                      if (!(await ConnectionVerify.connectionStatus())) {
                        showInSnackBar(
                            value:
                                "No Internet connection. Please connect to the internet and then try again.",
                            color: Colors.red);
                        return 0;
                      }

                      try {
                        var authService = FirebaseAuthService();

                        var check = await authService.signInWithGoogle();
                        if (check is String) {
                          showInSnackBar(
                              value: check, color: Colors.red, sec: 8);
                          return 0;
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      } catch (e) {
                        print(e);
                        if (e is PlatformException) {
                          String errorMessage =
                              getErrorMessage1(errorCode: e.code);
                          if (errorMessage != null) {
                            showInSnackBar(
                                value: "${e.message}",
                                color: Colors.red,
                                sec: 8);
                            return 0;
                          }
                        }

                        if (e is FirebaseAuthException) {
                          String errorMessage =
                              getErrorMessage1(errorCode: e.code);
                          showInSnackBar(
                              value: "$errorMessage.",
                              color: Colors.red,
                              sec: 8);
                          return 0;
                        }
                        showInSnackBar(
                            value: "Unknown error occured.",
                            color: Colors.red,
                            sec: 8);
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/google_logo.png',
                          height: 48.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: new Text(
                            "Sign in with Google",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
