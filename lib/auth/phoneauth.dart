import 'package:fix_it/auth/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phonenumberController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 250),
            Text(
              'Enter Your Phone Number:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: phonenumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      if (phonenumberController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please enter your phone number'),
                        ));
                        return;
                      }
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          verificationCompleted: (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException ex) {
                            setState(() {
                              _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Verification failed. Please try again.'),
                            ));
                          },
                          codeSent: (String verificationId, int? resendtoken) {
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPScreen(verificationId: verificationId),
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                          phoneNumber: phonenumberController.text.toString(),
                        );
                      } catch (ex) {
                        setState(() {
                          _isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('An error occurred. Please try again later.'),
                        ));
                      }
                    },
                    child: Text('Submit',style:TextStyle(color: Colors.white)),
                  ),
          ],
        ),
      ),
    );
  }
}
