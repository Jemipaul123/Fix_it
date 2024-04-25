import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fix_it/booked_services.dart'; // Import BookedServices screen

class ChooseTime extends StatefulWidget {
  final String selectedDocID;

  const ChooseTime({Key? key, required this.selectedDocID}) : super(key: key);

  @override
  State<ChooseTime> createState() => _ChooseTimeState();
}

class _ChooseTimeState extends State<ChooseTime> {
  TimeOfDay selectedTime = TimeOfDay.now();
  bool showConfirmationMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () {
                  setState(() {
                    showConfirmationMessage = true;
                  });

                  // Delay navigation to BookedServices after 2 seconds
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookedServices(documentId: widget.selectedDocID), // Pass the selected documentId
                      ),
                    );
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
                          builder: (context) => BookedServices(documentId: widget.selectedDocID), // Pass the selected documentId
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
