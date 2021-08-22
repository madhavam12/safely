import 'package:flutter/material.dart';

void loadingBar(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 15),
              Text(
                "Requesting",
                style: TextStyle(
                    fontFamily: "QuickSand", fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    },
  );
}
