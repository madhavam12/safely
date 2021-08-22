import 'package:flutter/material.dart';

class TNCPage extends StatelessWidget {
  const TNCPage({Key key}) : super(key: key);

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
                "Terms and conditions page(dummy)",
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
