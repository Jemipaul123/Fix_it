import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fix_it/booked_services.dart'; // Import BookedServices screen
import 'package:intl/intl.dart'; // Import DateFormat class

class ChooseTime1 extends StatefulWidget {
  final String selectedDocID;

  const ChooseTime1({Key? key, required this.selectedDocID}) : super(key: key);

  @override
  State<ChooseTime1> createState() => _ChooseTime1State();
}

class _ChooseTime1State extends State<ChooseTime1> {
  TimeOfDay selectedTime = TimeOfDay.now();
  bool showConfirmationMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!showConfirmationMessage)
              Text("${selectedTime.hour}:${selectedTime.minute}"),
            if (!showConfirmationMessage)
              ElevatedButton(
                child: const Text("Choose Time"),
                onPressed: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                    initialEntryMode: TimePickerEntryMode.dial,
                  );

                  if (timeOfDay != null) {
                    setState(() {
                      selectedTime = timeOfDay;
                    });
                  }
                },
              ),
            if (!showConfirmationMessage)
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showConfirmationMessage = true;
                  });

                  // Delay navigation to BookedServices after 2 seconds
                  Future.delayed(Duration(seconds: 2), () async {
                    final User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // Get user's first name and last name from 'customers' collection
                      final userData = await FirebaseFirestore.instance
                          .collection('customers')
                          .doc(user.uid)
                          .get();

                      final String firstName = userData['first name'];
                      final String lastName = userData['last name'];

                      final DateTime now = DateTime.now();
                      final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                      final String formattedTime = '${selectedTime.hour}:${selectedTime.minute}';

                      // Send the selected time, date, first name, and last name to the backend
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.selectedDocID)
                          .collection('services')
                          .add({
                        'user_id': user.uid,
                        'first_name': firstName,
                        'last_name': lastName,
                        'date': formattedDate,
                        'time': formattedTime,
                        'done': false, // Set done to false by default
                      });

                      // Set the worker's availability to false
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.selectedDocID)
                          .update({
                        'Available': false,
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookedServices1(documentId: widget.selectedDocID), // Pass the selected documentId
                        ),
                      );
                    }
                  });
                },
                child: const Text("Confirm"),
              ),
            if (showConfirmationMessage)
              AlertDialog(
                title: Text("Congratulations!"),
                content: Text("Your help will soon find you"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookedServices1(documentId: widget.selectedDocID), // Pass the selected documentId
                        ),
                      );
                    },
                    child: Text("Proceed"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
class ChooseTime2 extends StatefulWidget {
  final String selectedDocID;

  const ChooseTime2({Key? key, required this.selectedDocID}) : super(key: key);

  @override
  State<ChooseTime2> createState() => _ChooseTime2State();
}

class _ChooseTime2State extends State<ChooseTime2> {
  TimeOfDay selectedTime = TimeOfDay.now();
  bool showConfirmationMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!showConfirmationMessage)
              Text("${selectedTime.hour}:${selectedTime.minute}"),
            if (!showConfirmationMessage)
              ElevatedButton(
                child: const Text("Choose Time"),
                onPressed: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                    initialEntryMode: TimePickerEntryMode.dial,
                  );

                  if (timeOfDay != null) {
                    setState(() {
                      selectedTime = timeOfDay;
                    });
                  }
                },
              ),
            if (!showConfirmationMessage)
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showConfirmationMessage = true;
                  });

                  // Delay navigation to BookedServices after 2 seconds
                  Future.delayed(Duration(seconds: 2), () async {
                    final User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // Get user's first name and last name from 'customers' collection
                      final userData = await FirebaseFirestore.instance
                          .collection('customers')
                          .doc(user.uid)
                          .get();

                      final String firstName = userData['first name'];
                      final String lastName = userData['last name'];

                      final DateTime now = DateTime.now();
                      final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                      final String formattedTime = '${selectedTime.hour}:${selectedTime.minute}';

                      // Send the selected time, date, first name, and last name to the backend
                      await FirebaseFirestore.instance
                          .collection('gardener')
                          .doc(widget.selectedDocID)
                          .collection('services')
                          .add({
                        'user_id': user.uid,
                        'first_name': firstName,
                        'last_name': lastName,
                        'date': formattedDate,
                        'time': formattedTime,
                        'done': false, // Set done to false by default
                      });

                      // Set the worker's availability to false
                      await FirebaseFirestore.instance
                          .collection('gardener')
                          .doc(widget.selectedDocID)
                          .update({
                        'Available': false,
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookedServices2(documentId: widget.selectedDocID), // Pass the selected documentId
                        ),
                      );
                    }
                  });
                },
                child: const Text("Confirm"),
              ),
            if (showConfirmationMessage)
              AlertDialog(
                title: Text("Congratulations!"),
                content: Text("Your help will soon find you"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookedServices2(documentId: widget.selectedDocID), // Pass the selected documentId
                        ),
                      );
                    },
                    child: Text("Proceed"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ChooseTime3 extends StatefulWidget {
  final String selectedDocID;

  const ChooseTime3({Key? key, required this.selectedDocID}) : super(key: key);

  @override
  State<ChooseTime3> createState() => _ChooseTime3State();
}

class _ChooseTime3State extends State<ChooseTime3> {
  TimeOfDay selectedTime = TimeOfDay.now();
  bool showConfirmationMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!showConfirmationMessage)
              Text("${selectedTime.hour}:${selectedTime.minute}"),
            if (!showConfirmationMessage)
              ElevatedButton(
                child: const Text("Choose Time"),
                onPressed: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                    initialEntryMode: TimePickerEntryMode.dial,
                  );

                  if (timeOfDay != null) {
                    setState(() {
                      selectedTime = timeOfDay;
                    });
                  }
                },
              ),
            if (!showConfirmationMessage)
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showConfirmationMessage = true;
                  });

                  // Delay navigation to BookedServices after 2 seconds
                  Future.delayed(Duration(seconds: 2), () async {
                    final User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // Get user's first name and last name from 'customers' collection
                      final userData = await FirebaseFirestore.instance
                          .collection('customers')
                          .doc(user.uid)
                          .get();

                      final String firstName = userData['first name'];
                      final String lastName = userData['last name'];

                      final DateTime now = DateTime.now();
                      final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                      final String formattedTime = '${selectedTime.hour}:${selectedTime.minute}';

                      // Send the selected time, date, first name, and last name to the backend
                      await FirebaseFirestore.instance
                          .collection('users2')
                          .doc(widget.selectedDocID)
                          .collection('services')
                          .add({
                        'user_id': user.uid,
                        'first_name': firstName,
                        'last_name': lastName,
                        'date': formattedDate,
                        'time': formattedTime,
                        'done': false, // Set done to false by default
                      });

                      // Set the worker's availability to false
                      await FirebaseFirestore.instance
                          .collection('users2')
                          .doc(widget.selectedDocID)
                          .update({
                        'Available': false,
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookedServices3(documentId: widget.selectedDocID), // Pass the selected documentId
                        ),
                      );
                    }
                  });
                },
                child: const Text("Confirm"),
              ),
            if (showConfirmationMessage)
              AlertDialog(
                title: Text("Congratulations!"),
                content: Text("Your help will soon find you"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookedServices3(documentId: widget.selectedDocID), // Pass the selected documentId
                        ),
                      );
                    },
                    child: Text("Proceed"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
class ChooseTime4 extends StatefulWidget {
  final String selectedDocID;

  const ChooseTime4({Key? key, required this.selectedDocID}) : super(key: key);

  @override
  State<ChooseTime4> createState() => _ChooseTime4State();
}

class _ChooseTime4State extends State<ChooseTime4> {
  TimeOfDay selectedTime = TimeOfDay.now();
  bool showConfirmationMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!showConfirmationMessage)
              Text("${selectedTime.hour}:${selectedTime.minute}"),
            if (!showConfirmationMessage)
              ElevatedButton(
                child: const Text("Choose Time"),
                onPressed: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                    initialEntryMode: TimePickerEntryMode.dial,
                  );

                  if (timeOfDay != null) {
                    setState(() {
                      selectedTime = timeOfDay;
                    });
                  }
                },
              ),
            if (!showConfirmationMessage)
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showConfirmationMessage = true;
                  });

                  // Delay navigation to BookedServices after 2 seconds
                  Future.delayed(Duration(seconds: 2), () async {
                    final User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // Get user's first name and last name from 'customers' collection
                      final userData = await FirebaseFirestore.instance
                          .collection('customers')
                          .doc(user.uid)
                          .get();

                      final String firstName = userData['first name'];
                      final String lastName = userData['last name'];

                      final DateTime now = DateTime.now();
                      final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                      final String formattedTime = '${selectedTime.hour}:${selectedTime.minute}';

                      // Send the selected time, date, first name, and last name to the backend
                      await FirebaseFirestore.instance
                          .collection('electrical')
                          .doc(widget.selectedDocID)
                          .collection('services')
                          .add({
                        'user_id': user.uid,
                        'first_name': firstName,
                        'last_name': lastName,
                        'date': formattedDate,
                        'time': formattedTime,
                        'done': false, // Set done to false by default
                      });

                      // Set the worker's availability to false
                      await FirebaseFirestore.instance
                          .collection('electrical')
                          .doc(widget.selectedDocID)
                          .update({
                        'Available': false,
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookedServices4(documentId: widget.selectedDocID), // Pass the selected documentId
                        ),
                      );
                    }
                  });
                },
                child: const Text("Confirm"),
              ),
            if (showConfirmationMessage)
              AlertDialog(
                title: Text("Congratulations!"),
                content: Text("Your help will soon find you"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookedServices4(documentId: widget.selectedDocID), // Pass the selected documentId
                        ),
                      );
                    },
                    child: Text("Proceed"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
