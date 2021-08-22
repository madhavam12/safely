import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            Image.asset('assets/images/dummy.png', height: 250),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "Privacy Policy page(dummy)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
