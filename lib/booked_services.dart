import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_it/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'chatpage.dart'; // Import the chat page widget

class BookedServices extends StatefulWidget {
  final String documentId;

  const BookedServices({Key? key, required this.documentId}) : super(key: key);

  @override
  _BookedServicesState createState() => _BookedServicesState();
}

class _BookedServicesState extends State<BookedServices> {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Booked Services', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(widget.documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              String status = data['Status'] == true ? 'Completed' : 'Pending';
              Color statusColor = data['Status'] == true ? Colors.green : Colors.red;
              return Center(
                child: Card(
                  color: Color(0xFF1B2154),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 36,
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF00030E),
                            size: 50,
                          ),
                        ),
                        Text(
                          'Details',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'First Name: ${data['first name']}',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          'Last Name: ${data['last name']}',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          'Job: ${data['job']}',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          'Experience: ${data['experience']} yrs',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          'Status: $status ',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          'Pending',
                          style: TextStyle(fontSize: 18, color: statusColor),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Get UID of the current user
                              User? currentUser = FirebaseAuth.instance.currentUser;
                              if (currentUser != null) {
                                String uid = currentUser.uid;
                                // Navigate to ChatPage with the UID
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ChatPage(uid: uid)),
                                );
                              }
                            },
                            child: Text('Chat'),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 45, 70, 160),
                              onPrimary: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text('User not found!', style: TextStyle(color: Colors.white)),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
