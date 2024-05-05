import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'components/button.dart';
import 'components/textfield.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  Future<void> signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      // Navigate to the next screen after successful sign-in if needed
      if (mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // Handle sign-in errors
      displayMessage(e.code);
      // Display a snackbar or any other error handling mechanism
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          message,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0,vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Welcome to Fix It',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24
                      ),
                    ),
                    Text(
                      "You've been missed",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Lottie.network(
                  'https://lottie.host/a78ea018-65ee-466d-aded-1dca3745c121/BqvasGczpH.json',
                 
                  height: 350,
                  width: 350,
                ),
               
                MyTextField(
                  
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false,
                  
                ),
                SizedBox(height: 25),
                MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 25),
                MyButton(
                  onTap: signIn,
                  text: 'Sign In',
                  
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
  "Still not a member",
  style: GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      // Add any additional styles here if needed
    ),
  ),
),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap:widget.onTap,
                      child: Text(
  "Sign Up",
  style: GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.blue,
      fontWeight:FontWeight.w500,
     
      // Add any additional styles here if needed
    ),
  ),
),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
