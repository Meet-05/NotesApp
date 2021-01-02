import 'package:flutter/material.dart';
import '../widgets/signup_button.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/introImage.png',
          ),
          Text('My Notes', style: TextStyle(fontSize: 40.0, wordSpacing: 2.0)),
          SizedBox(
            height: 20.0,
          ),
          SignupButton(),
        ],
      ),
    );
  }
}
