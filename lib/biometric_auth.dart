import 'package:biometric_auth/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth extends StatefulWidget {
  @override
  _BiometricAuth createState() => _BiometricAuth();
}

class _BiometricAuth extends State<BiometricAuth> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;
  String _isAuthorized = "Not Authorized";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listofBiometrics;
    try {
      listofBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (listofBiometrics.contains(BiometricType.face)) {
      print('faceId');
    } else if (listofBiometrics.contains(BiometricType.fingerprint)) {
      print('fingerprint');
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listofBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to proceed!",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _isAuthorized = "Authorized";
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => MainPage()));
      } else {
        _isAuthorized = "Unauthorized";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_availableBiometricTypes.toString());
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: _checkBiometric,
                  child: Text("Check Biometric"),
                  color: Colors.lime,
                ),
                SizedBox(
                  width: 10,
                ),
                _canCheckBiometric == true
                    ? Image.asset(
                        'assets/checked.png',
                        height: 50.0,
                        width: 50.0,
                      )
                    : Icon(
                        Icons.cancel,
                        color: Colors.lime,
                        size: 50,
                      ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: _getListOfBiometricTypes,
                  child: Text("Available Biometric Types"),
                  color: Colors.lime,
                ),
                SizedBox(
                  width: 10,
                ),
                _availableBiometricTypes.toString() ==
                        '[BiometricType.fingerprint]'
                    ? Text('fingerprint')
                    : Text('${_availableBiometricTypes.toString()}'),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Authorization : "),
                _isAuthorized == 'Authorized'
                    ? Image.asset(
                        'assets/checked.png',
                        height: 50.0,
                        width: 50.0,
                      )
                    : Text('Unauthorized'),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              onPressed: _authorizeNow,
              child: Image.asset(
                'assets/fingerprint.png',
                height: 100.0,
                width: 100.0,
              ),
              color: Colors.white,
              elevation: 0,
            ),
          ],
        ),
      ],
    );
  }
}
