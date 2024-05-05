import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fix_it/auth/auth.dart';
import 'package:fix_it/home_page.dart';
import 'package:fix_it/worker/workerdetail.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showUserDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Column(
        children: [
          showUserDetails
              ? UserDetails()
              : WorkerOrCustomerPage(onCustomerSelected: () {
                  setState(() {
                    showUserDetails = true;
                  });
                }),
        ],
      ),
    );
  }
}

class WorkerOrCustomerPage extends StatelessWidget {
  final VoidCallback onCustomerSelected;

  const WorkerOrCustomerPage({required this.onCustomerSelected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 150),
          Text(
            'Sign up as',
            style: GoogleFonts.poppins( // Use Google Fonts for the text style
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 39, 38, 38),
            ),
            child: Text(
              'Worker',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'or',
            style: GoogleFonts.poppins( // Use Google Fonts for the text style
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserDetails()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 39, 38, 38),
            ),
            child: Text(
              'Customer',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();

  final _phoneNumberRegExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> register() async {
    if (_phoneNumberRegExp.hasMatch(phonenumberController.text)) {
      await addUserDetails(
        firstnameController.text.trim(),
        lastnameController.text.trim(),
        locationController.text.trim(),
        int.parse(phonenumberController.text.trim()),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Phone Number'),
            content: Text('Please enter a valid phone number.'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> addUserDetails(String firstname, String lastname, String location, int phonenumber) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('customers').doc(user.uid).set({
        'first name': firstname,
        'last name': lastname,
        'location': location,
        'phonenumber': phonenumber,
      });
    } else {
      print('User not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('customers').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
             backgroundColor: Color.fromARGB(255, 233, 227, 244),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
             backgroundColor: Color.fromARGB(255, 233, 227, 244),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.exists) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          });
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 233, 227, 244),
              actions: [
                IconButton(
                  onPressed: () {
                    signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthPage()),
                    );
                  },
                  icon: Icon(Icons.logout, color: Colors.black),
                ),
              ],
            ),
            backgroundColor: Color.fromARGB(255, 233, 227, 244),
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 233, 227, 244),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 80),
                  Text(
                    'Fill up the Details',
                    style: GoogleFonts.poppins( // Use Google Fonts for the text style
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 39, 38, 38),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: firstnameController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Firstname',
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: lastnameController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Lastname',
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: locationController,
                    style: TextStyle(color: Color(0xFF434754)),
                    decoration: InputDecoration(
                      hintText: 'Location',
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: phonenumberController,
                    style: TextStyle(color: Color(0xFF434754)),
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 39, 38, 38),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
  'Register',
  style: GoogleFonts.poppins( // Use Google Fonts for the text style
    textStyle: TextStyle(color: Colors.white),
  ),
),

                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
