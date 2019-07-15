import 'package:biometric_auth/biometric_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        elevation: 0,
        title: Text('Biometric Auth'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(40, 100),
                topRight: Radius.elliptical(40, 100))),
        child: Container(
          margin: MediaQuery.of(context).orientation == Orientation.portrait
              ? EdgeInsets.only(top: 100)
              : EdgeInsets.only(top: 0),
          child: BiometricAuth(),
        ),
      ),
    );
  }
}
