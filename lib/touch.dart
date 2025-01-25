import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class TouchID extends StatefulWidget {
  @override
  _TouchIDState createState() => _TouchIDState();
}

class _TouchIDState extends State<TouchID> {
  final LocalAuthentication localAuth = LocalAuthentication();
  String _authorizeText = 'Not Authorized!';
  List<BiometricType> availableBiometrics = [];

  Future<void> _authorize() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await localAuth.authenticate(
        localizedReason: 'Please authenticate to complete this process',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      print('Error: $e');
    }

    if (!mounted) return;

    setState(() {
      _authorizeText = isAuthorized ? "Authorized Successfully!" : "Not Authorized!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Touch ID Auth Example')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _authorizeText,
                style: TextStyle(color: Colors.black38, fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: _authorize,
              child: Text(
                'Authorize',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
