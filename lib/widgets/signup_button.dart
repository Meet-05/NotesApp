import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../provider/google_signin_provider.dart';

class SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      borderSide: BorderSide(color: Colors.white),
      padding: EdgeInsets.all(20.0),
      shape: StadiumBorder(),
      icon: FaIcon(
        FontAwesomeIcons.google,
        color: Colors.red,
      ),
      label: Text(
        'Sign in With Google',
        style: TextStyle(fontSize: 25.0),
      ),
      onPressed: () {
        Provider.of<GoogleSignInProvider>(context, listen: false).login();
      },
    );
  }
}
