import 'package:fix_it/auth/auth.dart';
import 'package:fix_it/auth/login_or_register.dart';
import 'package:fix_it/auth/otpscreen.dart';
import 'package:fix_it/auth/phoneauth.dart';
import 'package:fix_it/booking.dart';
import 'package:fix_it/home_page.dart';
import 'package:fix_it/services/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'LoginPage.dart';
import 'auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Assuming you have a screen1.dart file for the home screen

void main() async {
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
        fontFamily: GoogleFonts.poppins().fontFamily,
        // Set Poppins as the default font
        primaryColor: Color.fromARGB(255, 233, 227, 244), // Change this to your desired primary color
        // Change this to your desired accent color
        // Change this to your desired font
        backgroundColor: Color.fromARGB(255, 233, 227, 244), // Set default background color
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF9352fc), // Set elevated button color
            textStyle: TextStyle(color: Colors.white), // Set default font color to white
          ),
        ),
      ),
      home: , // Assuming you have a HomeScreen widget for the first page
    );
  }
}
