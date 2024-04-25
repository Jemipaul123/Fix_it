import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_it/workcust.dart';
import 'package:flutter/material.dart';

import 'login_or_register.dart';
import '../home_page.dart';
import '../LoginPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            return  SignUp();
          }
          // User is not logged in
          else {
            return LoginOrRegister();
            
          }
        },
      ),
    );
  }
}