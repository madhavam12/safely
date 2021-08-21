import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 9),
                    Image.asset('assets/images/heartGif.gif', height: 250),
                    SizedBox(height: 25),
                    Text(
                      "All the illustrations used in the app are downloaded from https://icons8.com/ and flaticon.com. I'm really thankful to them for letting me use their graphics for free.",
                      maxLines: 15,
                      style: TextStyle(
                        color: Colors.orange,
                        fontFamily: "QuickSand",
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
