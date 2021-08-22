import 'package:flutter/material.dart';

class NoRequests extends StatelessWidget {
  const NoRequests({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/nf.png', height: 250),
            SizedBox(height: 20),
            Text(
              "No requests found",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "QuickSand",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
