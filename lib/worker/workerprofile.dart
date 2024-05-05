import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Workerprofile1 extends StatelessWidget {
  const Workerprofile1({Key? key}) : super(key: key);

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
        stream: FirebaseFirestore.instance.collection('users').doc(currentUserUID).snapshots(),
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
          final availability = userData['Available'] ?? '';
          final job = userData['job'] ?? '';
          final experience = userData['experience'] ?? '';

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
                    _buildProfileInfo('Available', '$availability'),
                    _buildProfileInfo('Experience', '$experience'),
                    _buildProfileInfo('Job', job),
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


class Workerprofile2 extends StatelessWidget {
  const Workerprofile2({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('gardener').doc(currentUserUID).snapshots(),
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
          final availability = userData['Available'] ?? '';
          final job = userData['job'] ?? '';
          final experience = userData['experience'] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('first Name: $firstName'),
                Text('last Name: $lastName'),
                Text('location: $location'),
                Text('phonenumber: $phoneNumber'),
                Text('Available: $availability'),
                Text('experience: $experience'),
                Text('job: $job'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Workerprofile3 extends StatelessWidget {
  const Workerprofile3({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users2').doc(currentUserUID).snapshots(),
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
          final availability = userData['Available'] ?? '';
          final job = userData['job'] ?? '';
          final experience = userData['experience'] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('first Name: $firstName'),
                Text('last Name: $lastName'),
                Text('location: $location'),
                Text('phonenumber: $phoneNumber'),
                Text('Available: $availability'),
                Text('experience: $experience'),
                Text('job: $job'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Workerprofile4 extends StatelessWidget {
  const Workerprofile4({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('electrical').doc(currentUserUID).snapshots(),
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
          final availability = userData['Available'] ?? '';
          final job = userData['job'] ?? '';
          final experience = userData['experience'] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('first Name: $firstName'),
                Text('last Name: $lastName'),
                Text('location: $location'),
                Text('phonenumber: $phoneNumber'),
                Text('Available: $availability'),
                Text('experience: $experience'),
                Text('job: $job'),
              ],
            ),
          );
        },
      ),
    );
  }
}

