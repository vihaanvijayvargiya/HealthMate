import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_mate/Notification%20Services/notification_services.dart';
import 'package:health_mate/Screens/helth_main_screen.dart';
import 'loginScreen.dart';

class AuthScreen extends StatefulWidget {

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return HealthMainScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred'));
          }
        }
        return LoginScreen();
      },
    );
  }
}
