import 'package:fix_it/auth/phoneauth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import the lottie package
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

import 'package:fix_it/auth/auth.dart';


class Buffer extends StatelessWidget {
  const Buffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.network( // Add Lottie animation here
                    'https://lottie.host/41006c99-e812-4082-a9ea-2aa76b191260/j8LMiL1l3M.json',
                    // Path to your animation file
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20), // Adjust spacing as needed
                Text(
                  'Fix It',
                  style: GoogleFonts.poppins( // Use GoogleFonts.poppins()
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF9352fc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sign in with mail',
                          style: GoogleFonts.poppins( // Use GoogleFonts.poppins()
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Icon color set to white
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PhoneAuth()),);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF9352fc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sign in with OTP',
                          style: GoogleFonts.poppins( // Use GoogleFonts.poppins()
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Icon color set to white
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
