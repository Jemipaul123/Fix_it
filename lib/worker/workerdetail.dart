import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fix_it/worker/workerpage.dart';
import 'package:fix_it/auth/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerDetails1 extends StatefulWidget {
  const WorkerDetails1({Key? key}) : super(key: key);

  @override
  _WorkerDetails1State createState() => _WorkerDetails1State();
}

class _WorkerDetails1State extends State<WorkerDetails1> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController availableController = TextEditingController();
  String selectedCountry = '';
  String selectedJob = 'Cleaner';

  final _phoneNumberRegExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

  @override
  void initState() {
    super.initState();
    // Check if user has already provided details
    checkUserDetails();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    locationController.dispose();
    phonenumberController.dispose();
    experienceController.dispose();
    availableController.dispose();
    super.dispose();
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  Future checkUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDetails = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDetails.exists) {
        // User details already exist, navigate to WorkerPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Worker1()),
        );
      }
    }
  }

  Future register() async {
    if (_phoneNumberRegExp.hasMatch(phonenumberController.text)) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Use the UID from Firebase Authentication
        String uid = user.uid;
        await addUserDetails(
          uid,
          firstnameController.text.trim(),
          lastnameController.text.trim(),
          locationController.text.trim(),
          int.parse(experienceController.text.trim()),
          availableController.text.trim() == 'Yes' ? true : false,
          int.parse(phonenumberController.text.trim()),
        );

        // Navigate to WorkerPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Worker1()),
        );
      } else {
        // Handle case when user is null
        // This shouldn't normally happen in this context
      }
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

  Future addUserDetails(String uid, String firstname, String lastname, String location,
      int experience, bool available, int phonenumber) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'uid': uid, // Save UID to easily reference user details
      'first name': firstname,
      'last name': lastname,
      'Available': available,
      'experience': experience,
      'location': location,
      'phonenumber': phonenumber,
      'job': selectedJob,
    });
  }

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.logout, color: Colors.black), // Set icon color to white
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
             
            Text(
              'Fill up the Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedJob,
              decoration: InputDecoration(
                labelText: 'Job',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedJob = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Cleaner',
                  child: Text('Cleaner'),
                ),
              ],
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<bool>(
              value: null,
              decoration: InputDecoration(
                labelText: 'Availability',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  availableController.text = value! ? 'Yes' : 'No';
                });
              },
              items: [
                DropdownMenuItem(
                  value: true,
                  child: Text('Yes'),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text('No'),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: experienceController,
              style: TextStyle(color: Color(0xFF434754)),
              decoration: InputDecoration(
                hintText: 'Experience in years',
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
                // Call register function
                register();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 39, 38, 38),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class WorkerDetails2 extends StatefulWidget {
  const WorkerDetails2({Key? key}) : super(key: key);

  @override
  _WorkerDetails2State createState() => _WorkerDetails2State();
}

class _WorkerDetails2State extends State<WorkerDetails2> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController availableController = TextEditingController();
  String selectedCountry = '';
  String selectedJob = 'Gardener';

  final _phoneNumberRegExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

  @override
  void initState() {
    super.initState();
    // Check if user has already provided details
    checkUserDetails();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    locationController.dispose();
    phonenumberController.dispose();
    experienceController.dispose();
    availableController.dispose();
    super.dispose();
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  Future checkUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDetails = await FirebaseFirestore.instance.collection('gardener').doc(user.uid).get();
      if (userDetails.exists) {
        // User details already exist, navigate to WorkerPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Worker2()),
        );
      }
    }
  }

  Future register() async {
    if (_phoneNumberRegExp.hasMatch(phonenumberController.text)) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Use the UID from Firebase Authentication
        String uid = user.uid;
        await addUserDetails(
          uid,
          firstnameController.text.trim(),
          lastnameController.text.trim(),
          locationController.text.trim(),
          int.parse(experienceController.text.trim()),
          availableController.text.trim() == 'Yes' ? true : false,
          int.parse(phonenumberController.text.trim()),
        );

        // Navigate to WorkerPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Worker2()),
        );
      } else {
        // Handle case when user is null
        // This shouldn't normally happen in this context
      }
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

  Future addUserDetails(String uid, String firstname, String lastname, String location,
      int experience, bool available, int phonenumber) async {
    await FirebaseFirestore.instance.collection('gardener').doc(uid).set({
      'uid': uid, // Save UID to easily reference user details
      'first name': firstname,
      'last name': lastname,
      'Available': available,
      'experience': experience,
      'location': location,
      'phonenumber': phonenumber,
      'job': selectedJob,
    });
  }

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.logout, color: Colors.black), // Set icon color to white
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
            
            Text(
              'Fill up the Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedJob,
              decoration: InputDecoration(
                labelText: 'Job',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedJob = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Gardener',
                  child: Text('Gardener'),
                ),
              ],
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<bool>(
              value: null,
              decoration: InputDecoration(
                labelText: 'Availability',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  availableController.text = value! ? 'Yes' : 'No';
                });
              },
              items: [
                DropdownMenuItem(
                  value: true,
                  child: Text('Yes'),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text('No'),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: experienceController,
              style: TextStyle(color: Color(0xFF434754)),
              decoration: InputDecoration(
                hintText: 'Experience in years',
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
                // Call register function
                register();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 39, 38, 38),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkerDetails3 extends StatefulWidget {
  const WorkerDetails3({Key? key}) : super(key: key);

  @override
  _WorkerDetails3State createState() => _WorkerDetails3State();
}

class _WorkerDetails3State extends State<WorkerDetails3> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController availableController = TextEditingController();
  String selectedCountry = '';
  String selectedJob = 'Plumber';

  final _phoneNumberRegExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

  @override
  void initState() {
    super.initState();
    // Check if user has already provided details
    checkUserDetails();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    locationController.dispose();
    phonenumberController.dispose();
    experienceController.dispose();
    availableController.dispose();
    super.dispose();
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  Future checkUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDetails = await FirebaseFirestore.instance.collection('users2').doc(user.uid).get();
      if (userDetails.exists) {
        // User details already exist, navigate to WorkerPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Worker3()),
        );
      }
    }
  }

  Future register() async {
    if (_phoneNumberRegExp.hasMatch(phonenumberController.text)) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Use the UID from Firebase Authentication
        String uid = user.uid;
        await addUserDetails(
          uid,
          firstnameController.text.trim(),
          lastnameController.text.trim(),
          locationController.text.trim(),
          int.parse(experienceController.text.trim()),
          availableController.text.trim() == 'Yes' ? true : false,
          int.parse(phonenumberController.text.trim()),
        );

        // Navigate to WorkerPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Worker3()),
        );
      } else {
        // Handle case when user is null
        // This shouldn't normally happen in this context
      }
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

  Future addUserDetails(String uid, String firstname, String lastname, String location,
      int experience, bool available, int phonenumber) async {
    await FirebaseFirestore.instance.collection('users2').doc(uid).set({
      'uid': uid, // Save UID to easily reference user details
      'first name': firstname,
      'last name': lastname,
      'Available': available,
      'experience': experience,
      'location': location,
      'phonenumber': phonenumber,
      'job': selectedJob,
    });
  }

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.logout, color: Colors.black), // Set icon color to white
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
            
            Text(
              'Fill up the Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedJob,
              decoration: InputDecoration(
                labelText: 'Job',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedJob = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Plumber',
                  child: Text('Plumber'),
                ),
              ],
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<bool>(
              value: null,
              decoration: InputDecoration(
                labelText: 'Availability',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  availableController.text = value! ? 'Yes' : 'No';
                });
              },
              items: [
                DropdownMenuItem(
                  value: true,
                  child: Text('Yes'),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text('No'),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: experienceController,
              style: TextStyle(color: Color(0xFF434754)),
              decoration: InputDecoration(
                hintText: 'Experience in years',
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
                // Call register function
                register();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 39, 38, 38),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkerDetails4 extends StatefulWidget {
  const WorkerDetails4({Key? key}) : super(key: key);

  @override
  _WorkerDetails4State createState() => _WorkerDetails4State();
}

class _WorkerDetails4State extends State<WorkerDetails4> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController availableController = TextEditingController();
  String selectedCountry = '';
  String selectedJob = 'Electrical';

  final _phoneNumberRegExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

  @override
  void initState() {
    super.initState();
    // Check if user has already provided details
    checkUserDetails();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    locationController.dispose();
    phonenumberController.dispose();
    experienceController.dispose();
    availableController.dispose();
    super.dispose();
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  Future checkUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDetails = await FirebaseFirestore.instance.collection('electrical').doc(user.uid).get();
      if (userDetails.exists) {
        // User details already exist, navigate to WorkerPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Worker4()),
        );
      }
    }
  }

  Future register() async {
    if (_phoneNumberRegExp.hasMatch(phonenumberController.text)) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Use the UID from Firebase Authentication
        String uid = user.uid;
        await addUserDetails(
          uid,
          firstnameController.text.trim(),
          lastnameController.text.trim(),
          locationController.text.trim(),
          int.parse(experienceController.text.trim()),
          availableController.text.trim() == 'Yes' ? true : false,
          int.parse(phonenumberController.text.trim()),
        );

        // Navigate to WorkerPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Worker4()),
        );
      } else {
        // Handle case when user is null
        // This shouldn't normally happen in this context
      }
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

  Future addUserDetails(String uid, String firstname, String lastname, String location,
      int experience, bool available, int phonenumber) async {
    await FirebaseFirestore.instance.collection('electrical').doc(uid).set({
      'uid': uid, // Save UID to easily reference user details
      'first name': firstname,
      'last name': lastname,
      'Available': available,
      'experience': experience,
      'location': location,
      'phonenumber': phonenumber,
      'job': selectedJob,
    });
  }

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.logout, color: Colors.white), // Set icon color to white
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
            
            Text(
              'Fill up the Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedJob,
              decoration: InputDecoration(
                labelText: 'Job',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedJob = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Electrical',
                  child: Text('Electrical'),
                ),
              ],
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<bool>(
              value: null,
              decoration: InputDecoration(
                labelText: 'Availability',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  availableController.text = value! ? 'Yes' : 'No';
                });
              },
              items: [
                DropdownMenuItem(
                  value: true,
                  child: Text('Yes'),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text('No'),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: experienceController,
              style: TextStyle(color: Color(0xFF434754)),
              decoration: InputDecoration(
                hintText: 'Experience in years',
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
                // Call register function
                register();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 39, 38, 38),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class JobPage extends StatelessWidget {
  const JobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( // Wrap the Column with a Container
      color: Color.fromARGB(255, 233, 227, 244), // Set background color
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 200),
            Center(
              child: Text(
  'Choose your Job!',
  style: GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 25,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
    ),
  ),
),

            ),
            SizedBox(height: 30),
            _buildHoverButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkerDetails1()),
                );
              },
              buttonText: 'Cleaner',
            ),
            SizedBox(height: 20),
            _buildHoverButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkerDetails2()),
                );
              },
              buttonText: 'Gardener',
            ),
            SizedBox(height: 20),
            _buildHoverButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkerDetails3()),
                );
              },
              buttonText: 'Plumber',
            ),
            SizedBox(height: 20),
            _buildHoverButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkerDetails4()),
                );
              },
              buttonText: 'Electrical',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoverButton({required VoidCallback onPressed, required String buttonText}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity(),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 39, 38, 38),
          ),
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}