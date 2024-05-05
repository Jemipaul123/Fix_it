import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_it/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'chatpage.dart'; // Import the chat page widget

class BookedServices1 extends StatefulWidget {
  final String documentId;

  const BookedServices1({Key? key, required this.documentId}) : super(key: key);

  @override
  _BookedServices1State createState() => _BookedServices1State();
}

class _BookedServices1State extends State<BookedServices1> {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
        title: Text('Booked Services ', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(widget.documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              String status;
              Color statusColor;
              if (data.containsKey('services')) {
                List<dynamic> services = data['services'];
                bool isCompleted = services.any((service) => service['done'] == true);
                status = isCompleted ? 'Completed' : 'Pending';
                statusColor = isCompleted ? Colors.green : Colors.red;
              } else {
                status = 'Pending';
                statusColor = Colors.red;
              }
              return Center(
                child: Card(
                  color: Color.fromARGB(255, 233, 227, 244),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    
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
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'First Name: ${data['first name']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Last Name: ${data['last name']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Job: ${data['job']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Experience: ${data['experience']} yrs',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                       
                        Text(
                          status,
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
                                  MaterialPageRoute(builder: (context) => ChatPage(uid1: widget.documentId)),
                                );
                              }
                            },
                            child: Text('Chat'),
                            style: ElevatedButton.styleFrom(
                              
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

// Repeat the same logic for BookedServices2, BookedServices3, and BookedServices4
class BookedServices2 extends StatefulWidget {
  final String documentId;

  const BookedServices2({Key? key, required this.documentId}) : super(key: key);

  @override
  _BookedServices2State createState() => _BookedServices2State();
}

class _BookedServices2State extends State<BookedServices2> {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
        title: Text('Booked Services ', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('gardener').doc(widget.documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              String status;
              Color statusColor;
              if (data.containsKey('services')) {
                List<dynamic> services = data['services'];
                bool isCompleted = services.any((service) => service['done'] == true);
                status = isCompleted ? 'Completed' : 'Pending';
                statusColor = isCompleted ? Colors.green : Colors.red;
              } else {
                status = 'Pending';
                statusColor = Colors.red;
              }
              return Center(
                child: Card(
                  color: Color.fromARGB(255, 233, 227, 244),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    
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
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'First Name: ${data['first name']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Last Name: ${data['last name']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Job: ${data['job']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Experience: ${data['experience']} yrs',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                       
                        Text(
                          status,
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
                                  MaterialPageRoute(builder: (context) => ChatPage(uid1: widget.documentId)),
                                );
                              }
                            },
                            child: Text('Chat'),
                            style: ElevatedButton.styleFrom(
                             
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
                child: Text('User not found!', style: TextStyle(color: Colors.black)),
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
class BookedServices3 extends StatefulWidget {
  final String documentId;

  const BookedServices3({Key? key, required this.documentId}) : super(key: key);

  @override
  _BookedServices3State createState() => _BookedServices3State();
}

class _BookedServices3State extends State<BookedServices3> {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
        title: Text('Booked Services ', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users2').doc(widget.documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              String status;
              Color statusColor;
              if (data.containsKey('services')) {
                List<dynamic> services = data['services'];
                bool isCompleted = services.any((service) => service['done'] == true);
                status = isCompleted ? 'Completed' : 'Pending';
                statusColor = isCompleted ? Colors.green : Colors.red;
              } else {
                status = 'Pending';
                statusColor = Colors.red;
              }
              return Center(
                child: Card(
                  color: Color.fromARGB(255, 233, 227, 244),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                   
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
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'First Name: ${data['first name']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Last Name: ${data['last name']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Job: ${data['job']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Experience: ${data['experience']} yrs',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                       
                        Text(
                          status,
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
                                  MaterialPageRoute(builder: (context) => ChatPage(uid1: widget.documentId)),
                                );
                              }
                            },
                            child: Text('Chat'),
                            style: ElevatedButton.styleFrom(
                              
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
                child: Text('User not found!', style: TextStyle(color: Colors.black)),
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
class BookedServices4 extends StatefulWidget {
  final String documentId;

  const BookedServices4({Key? key, required this.documentId}) : super(key: key);

  @override
  _BookedServices4State createState() => _BookedServices4State();
}

class _BookedServices4State extends State<BookedServices4> {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
        title: Text('Booked Services ', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('electrical').doc(widget.documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              String status;
              Color statusColor;
              if (data.containsKey('services')) {
                List<dynamic> services = data['services'];
                bool isCompleted = services.any((service) => service['done'] == true);
                status = isCompleted ? 'Completed' : 'Pending';
                statusColor = isCompleted ? Colors.green : Colors.red;
              } else {
                status = 'Pending';
                statusColor = Colors.red;
              }
              return Center(
                child: Card(
                  color: Color.fromARGB(255, 233, 227, 244),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                
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
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'First Name: ${data['first name']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Last Name: ${data['last name']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Job: ${data['job']}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          'Experience: ${data['experience']} yrs',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                       
                        Text(
                          status,
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
                                  MaterialPageRoute(builder: (context) => ChatPage(uid1: widget.documentId)),
                                );
                              }
                            },
                            child: Text('Chat'),
                            style: ElevatedButton.styleFrom(
                            
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