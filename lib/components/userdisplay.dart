import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDisplay extends StatelessWidget {
  const UserDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserUID = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserUID == null) {
      // User is not authenticated
      return Scaffold(
        body: Center(
          child: Text('User not authenticated'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 227, 244),
        title: Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('customers').doc(currentUserUID).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('No user data found'),
            );
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final firstName = userData['first name'] ?? '';
          final lastName = userData['last name'] ?? '';
          final location = userData['location'] ?? '';
          final phoneNumber = userData['phonenumber'] ?? '';
          

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Color.fromARGB(255, 233, 227, 244),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Color.fromARGB(219, 99, 68, 159),
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildProfileInfo('Name', '$firstName $lastName'),
                    _buildProfileInfo('Location', '$location'),
                    _buildProfileInfo('Phone Number', '$phoneNumber'),
                   
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileInfo(String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$title:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      SizedBox(width: 6),
      Expanded(
        child: Text(
          value,
          style: TextStyle(fontSize: 17),
        ),
      ),
    ],
  );
}
}


