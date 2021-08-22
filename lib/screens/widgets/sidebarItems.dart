import 'package:flutter/material.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:safely/services/firebaseAuthService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safely/screens/loginScreen.dart';

import '../tnCPage.dart';
import '../creditsPage.dart';
import '../privacyPolicyPage.dart';

String email = 'madhavam.shahi.12@gmail.com';

Widget buildMenu(context, _endSideMenuKey) {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(vertical: 50.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LListItem(
          backgroundColor: Colors.transparent,
          onTap: () {
            final _state = _endSideMenuKey.currentState;

            if (_state.isOpened)
              _state.closeSideMenu();
            else
              _state.openSideMenu();
          },
          leading:
              Icon(LineAwesomeIcons.home, size: 22.50, color: Colors.black),
          title: Text("Home",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Quicksand",
              )),
          textColor: Colors.white,
          dense: true,
        ),
        LListItem(
          backgroundColor: Colors.transparent,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TNCPage()));
          },
          leading: Icon(LineAwesomeIcons.paperclip,
              size: 22.50, color: Colors.black),
          title: Text("Terms and Conditions",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Quicksand",
              )),
          textColor: Colors.white,
          dense: true,

          // padding: EdgeInsets.zero,
        ),
        LListItem(
          backgroundColor: Colors.transparent,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
          },
          leading:
              Icon(LineAwesomeIcons.file, size: 22.50, color: Colors.black),
          title: Text("Privacy Policy",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Quicksand",
              )),
          textColor: Colors.white,
          dense: true,

          // padding: EdgeInsets.zero,
        ),
        LListItem(
          backgroundColor: Colors.transparent,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreditsPage()));
          },
          leading:
              Icon(LineAwesomeIcons.feather, size: 22.50, color: Colors.black),
          title: Text("Credits",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Quicksand",
              )),
          textColor: Colors.white,
          dense: true,
        ),
        LListItem(
          backgroundColor: Colors.transparent,
          onTap: () {
            final Uri _emailLaunchUri = Uri(
                scheme: 'mailto',
                path: email,
                queryParameters: {'subject': 'Suggestions / Bug Report'});

            launch(_emailLaunchUri.toString());
          },
          leading:
              Icon(LineAwesomeIcons.phone, size: 22.50, color: Colors.black),
          title: Text("Contact",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Quicksand",
              )),
          textColor: Colors.white,
          dense: true,

          // padding: EdgeInsets.zero,
        ),
        LListItem(
          backgroundColor: Colors.transparent,
          onTap: () {
            final Uri _emailLaunchUri = Uri(
                scheme: 'mailto',
                path: email,
                queryParameters: {'subject': 'Suggestions / Bug Report'});

            launch(_emailLaunchUri.toString());
          },
          leading: Icon(LineAwesomeIcons.bug, size: 22.50, color: Colors.black),
          title: Text("Report a bug",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Quicksand",
              )),
          textColor: Colors.white,
          dense: true,

          // padding: EdgeInsets.zero,
        ),
        LListItem(
          backgroundColor: Colors.transparent,
          onTap: () async {
            FirebaseAuthService _authService = FirebaseAuthService();
            await _authService.signOut();
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          leading: Icon(LineAwesomeIcons.arrow_left,
              size: 22.50, color: Colors.black),
          title: Text("Log out",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Quicksand",
              )),
          textColor: Colors.white,
          dense: true,

          // padding: EdgeInsets.zero,
        ),
      ],
    ),
  );
}
