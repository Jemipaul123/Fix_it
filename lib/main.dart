import 'package:fix_it/auth/auth.dart';
import 'package:fix_it/auth/login_or_register.dart';
import 'package:fix_it/home_page.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Assuming you have a screen1.dart file for the home screen

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FixItApp());
}


class FixItApp extends StatelessWidget {
  const FixItApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define your app's theme here
        primaryColor: Colors.blue, // Change this to your desired primary color
        // Change this to your desired accent color
        fontFamily: 'Roboto', // Change this to your desired font
      ),
      home:AuthPage(), // Assuming you have a HomeScreen widget for the first page
    );
  }
}
