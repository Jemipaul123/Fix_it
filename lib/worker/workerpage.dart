import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_it/chatpage.dart';
import 'package:fix_it/components/my_drawer.dart';

class Worker1 extends StatefulWidget {
  const Worker1({Key? key}) : super(key: key);

  @override
  State<Worker1> createState() => _Worker1State();
}

class _Worker1State extends State<Worker1> {
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
        title: Text('Bookings'),
         backgroundColor: Color.fromARGB(255, 233, 227, 244),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawer1(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(currentUserUID).collection('services').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No current bookings'),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((serviceDoc) {
                Map<String, dynamic> serviceData = serviceDoc.data() as Map<String, dynamic>;
                // Assuming 'firstName', 'lastName', 'date', 'time', and 'done' fields exist in each service document
                String firstName = serviceData['first_name'] ?? ''; // Using empty string as default if field doesn't exist
                String lastName = serviceData['last_name'] ?? '';
                String date = serviceData['date'] ?? '';
                String time = serviceData['time'] ?? '';
                String customer_id = serviceData['user_id'] ?? '';
                bool done = serviceData['done'] ?? false; // Default to false if 'done' field doesn't exist

                return done
                    ? SizedBox() // If 'done' is true, return an empty SizedBox to hide the ListTile
                    : Card(
                        child: ListTile(
                          title: Text('$firstName $lastName'),
                          subtitle: Text('Date: $date, Time: $time'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Update 'done' field to true when 'Done' button is clicked
                                  FirebaseFirestore.instance.collection('users').doc(currentUserUID).collection('services').doc(serviceDoc.id).update({
                                    'done': true,
                                  }).then((_) {
                                    // Delete the card from the UI
                                    setState(() {
                                      snapshot.data!.docs.remove(serviceDoc);
                                    });
                                    // Delete the document from Firestore
                                    FirebaseFirestore.instance.collection('users').doc(currentUserUID).collection('services').doc(serviceDoc.id).delete().then((_) {
                                      // Perform any other operations if needed after deleting the document
                                    }).catchError((error) {
                                      // Handle errors
                                      print("Failed to delete document: $error");
                                    });
                                  }).catchError((error) {
                                    // Handle errors
                                    print("Failed to update 'done' field: $error");
                                  });
                                },
                                child: Text('Done',style:TextStyle(color: Colors.white)),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle 'Chat' button press
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(uid1: customer_id),
                                    ),
                                  );
                                },
                                child: Text('Chat',style:TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}

class Worker2 extends StatefulWidget {
  const Worker2({Key? key}) : super(key: key);

  @override
  State<Worker2> createState() => _Worker2State();
}

class _Worker2State extends State<Worker2> {
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
        title: Text('Bookings'),
         backgroundColor: Color.fromARGB(255, 233, 227, 244),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawer1(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('gardener').doc(currentUserUID).collection('services').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No current bookings'),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((serviceDoc) {
                Map<String, dynamic> serviceData = serviceDoc.data() as Map<String, dynamic>;
                // Assuming 'firstName', 'lastName', 'date', 'time', and 'done' fields exist in each service document
                String firstName = serviceData['first_name'] ?? ''; // Using empty string as default if field doesn't exist
                String lastName = serviceData['last_name'] ?? '';
                String date = serviceData['date'] ?? '';
                String time = serviceData['time'] ?? '';
                String customer_id = serviceData['user_id'] ?? '';
                bool done = serviceData['done'] ?? false; // Default to false if 'done' field doesn't exist

                return done
                    ? SizedBox() // If 'done' is true, return an empty SizedBox to hide the ListTile
                    : Card(
                        child: ListTile(
                          title: Text('$firstName $lastName'),
                          subtitle: Text('Date: $date, Time: $time'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Update 'done' field to true when 'Done' button is clicked
                                  FirebaseFirestore.instance.collection('gardener').doc(currentUserUID).collection('services').doc(serviceDoc.id).update({
                                    'done': true,
                                  }).then((_) {
                                    // Delete the card from the UI
                                    setState(() {
                                      snapshot.data!.docs.remove(serviceDoc);
                                    });
                                    // Delete the document from Firestore
                                    FirebaseFirestore.instance.collection('gardener').doc(currentUserUID).collection('services').doc(serviceDoc.id).delete().then((_) {
                                      // Perform any other operations if needed after deleting the document
                                    }).catchError((error) {
                                      // Handle errors
                                      print("Failed to delete document: $error");
                                    });
                                  }).catchError((error) {
                                    // Handle errors
                                    print("Failed to update 'done' field: $error");
                                  });
                                },
                                child: Text('Done',style:TextStyle(color: Colors.white)),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle 'Chat' button press
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(uid1: customer_id),
                                    ),
                                  );
                                },
                                child: Text('Chat',style:TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}

class Worker3 extends StatefulWidget {
  const Worker3({Key? key}) : super(key: key);

  @override
  State<Worker3> createState() => _Worker3State();
}

class _Worker3State extends State<Worker3> {
  @override
  Widget build(BuildContext context) {
    final currentUserUID = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserUID == null) {
      // User is not authenticated
      return Scaffold(
         backgroundColor: Color.fromARGB(255, 233, 227, 244),
        body: Center(
          child: Text('User not authenticated'),
        ),
      );
    }

    return Scaffold(
       backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 233, 227, 244),
        title: Text('Bookings'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawer1(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users2').doc(currentUserUID).collection('services').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No current bookings'),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((serviceDoc) {
                Map<String, dynamic> serviceData = serviceDoc.data() as Map<String, dynamic>;
                // Assuming 'firstName', 'lastName', 'date', 'time', and 'done' fields exist in each service document
                String firstName = serviceData['first_name'] ?? ''; // Using empty string as default if field doesn't exist
                String lastName = serviceData['last_name'] ?? '';
                String date = serviceData['date'] ?? '';
                String time = serviceData['time'] ?? '';
                String customer_id = serviceData['user_id'] ?? '';
                bool done = serviceData['done'] ?? false; // Default to false if 'done' field doesn't exist

                return done
                    ? SizedBox() // If 'done' is true, return an empty SizedBox to hide the ListTile
                    : Card(
                        child: ListTile(
                          title: Text('$firstName $lastName'),
                          subtitle: Text('Date: $date, Time: $time'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Update 'done' field to true when 'Done' button is clicked
                                  FirebaseFirestore.instance.collection('users2').doc(currentUserUID).collection('services').doc(serviceDoc.id).update({
                                    'done': true,
                                  }).then((_) {
                                    // Delete the card from the UI
                                    setState(() {
                                      snapshot.data!.docs.remove(serviceDoc);
                                    });
                                    // Delete the document from Firestore
                                    FirebaseFirestore.instance.collection('users2').doc(currentUserUID).collection('services').doc(serviceDoc.id).delete().then((_) {
                                      // Perform any other operations if needed after deleting the document
                                    }).catchError((error) {
                                      // Handle errors
                                      print("Failed to delete document: $error");
                                    });
                                  }).catchError((error) {
                                    // Handle errors
                                    print("Failed to update 'done' field: $error");
                                  });
                                },
                                child: Text('Done'),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle 'Chat' button press
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(uid1: customer_id),
                                    ),
                                  );
                                },
                                child: Text('Chat',style:TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
class Worker4 extends StatefulWidget {
  const Worker4({Key? key}) : super(key: key);

  @override
  State<Worker4> createState() => _Worker4State();
}

class _Worker4State extends State<Worker4> {
  @override
  Widget build(BuildContext context) {
    final currentUserUID = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserUID == null) {
      // User is not authenticated
      return Scaffold(
         backgroundColor: Color.fromARGB(255, 233, 227, 244),
        body: Center(
          child: Text('User not authenticated'),
        ),
      );
    }

    return Scaffold(
       backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 233, 227, 244),
        title: Text('Bookings'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawer1(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(currentUserUID).collection('services').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No current bookings'),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((serviceDoc) {
                Map<String, dynamic> serviceData = serviceDoc.data() as Map<String, dynamic>;
                // Assuming 'firstName', 'lastName', 'date', 'time', and 'done' fields exist in each service document
                String firstName = serviceData['first_name'] ?? ''; // Using empty string as default if field doesn't exist
                String lastName = serviceData['last_name'] ?? '';
                String date = serviceData['date'] ?? '';
                String time = serviceData['time'] ?? '';
                String customer_id = serviceData['user_id'] ?? '';
                bool done = serviceData['done'] ?? false; // Default to false if 'done' field doesn't exist

                return done
                    ? SizedBox() // If 'done' is true, return an empty SizedBox to hide the ListTile
                    : Card(
                        child: ListTile(
                          title: Text('$firstName $lastName'),
                          subtitle: Text('Date: $date, Time: $time'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Update 'done' field to true when 'Done' button is clicked
                                  FirebaseFirestore.instance.collection('electrical').doc(currentUserUID).collection('services').doc(serviceDoc.id).update({
                                    'done': true,
                                  }).then((_) {
                                    // Delete the card from the UI
                                    setState(() {
                                      snapshot.data!.docs.remove(serviceDoc);
                                    });
                                    // Delete the document from Firestore
                                    FirebaseFirestore.instance.collection('electrical').doc(currentUserUID).collection('services').doc(serviceDoc.id).delete().then((_) {
                                      // Perform any other operations if needed after deleting the document
                                    }).catchError((error) {
                                      // Handle errors
                                      print("Failed to delete document: $error");
                                    });
                                  }).catchError((error) {
                                    // Handle errors
                                    print("Failed to update 'done' field: $error");
                                  });
                                },
                                child: Text('Done',style:TextStyle(color: Colors.white)),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle 'Chat' button press
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(uid1: customer_id),
                                    ),
                                  );
                                },
                                child: Text('Chat',style:TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
