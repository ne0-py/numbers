import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  final String loadingMessage;

  Loading({required this.loadingMessage});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.loadingMessage,
            style: TextStyle(
                fontFamily: "Raleway",
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
          SpinKitSquareCircle(
            color: Colors.black,
            size: 80,
          ),
        ],
      ),
    );
  }
}
