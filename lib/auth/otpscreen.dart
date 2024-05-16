import 'dart:developer'; // Import 'log' function

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_it/workcust.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId; // Corrected variable name

  OTPScreen({Key? key, required this.verificationId}) : super(key: key); // Corrected constructor syntax

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController OTPController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter OTP:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: OTPController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: OTPController.text.toString(),
                  );
                  await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  });
                } catch (ex) {
                  log(ex.toString());
                }
              },
              child: Text('Submit OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
