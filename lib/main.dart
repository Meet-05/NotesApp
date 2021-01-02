import 'package:NotesApp/widgets/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:NotesApp/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './provider/google_signin_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primaryColor: Color(0xFF706897),
        accentColor: Colors.white,
        scaffoldBackgroundColor: Color(0xFF9088d4),
        fontFamily: 'JosefinSans',
      ),
      home: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final signInProvider = Provider.of<GoogleSignInProvider>(context);
              if (signInProvider.isSigningIn) {
                return Center(child: LoadingScreen());
              } else if (snapshot.hasData) {
                return HomeScreen();
              } else {
                return AuthScreen();
              }
            }),
      ),
    );
  }
}
