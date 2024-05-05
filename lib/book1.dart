import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fix_it/booking.dart'; // Import Booking widget

class Book1 extends StatelessWidget {
 
  final String? selectedDocID;

  const Book1({
    Key? key,
    required this.selectedDocID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedDocID == null) {
      // Handle the case where selectedDocID is null
      return Scaffold(
        body: Center(
          child: Text('Error: selectedDocID is null!'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
        title: Text('Book Now', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(selectedDocID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return Center(
                child: Card(
                  color: Color.fromARGB(255, 233, 227, 244),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color:Color.fromARGB(255, 233, 227, 244) , width: 1),
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
                        SizedBox(height: 20),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Implement rating update functionality if needed
                          },
                        ),//Booking1(selectedDocID: selectedDocID!)
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child:ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Booking1(selectedDocID: selectedDocID!),
      ),
    );
  },
  child: Text('Book'),
  style: ElevatedButton.styleFrom(
    minimumSize: Size(50, 50),
    primary: Color(0xFF9352fc),
    onPrimary: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5), // Adjust the circular radius here
    ),
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
class Book2 extends StatelessWidget {
 
  final String? selectedDocID;

  const Book2({
    Key? key,
    required this.selectedDocID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedDocID == null) {
      // Handle the case where selectedDocID is null
      return Scaffold(
        body: Center(
          child: Text('Error: selectedDocID is null!'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
        title: Text('Book Now', style: TextStyle(color: Colors.black)),
        backgroundColor:Color.fromARGB(255, 233, 227, 244),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('gardener').doc(selectedDocID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return Center(
                child: Card(
                 color:Color.fromARGB(255, 233, 227, 244),
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
                        SizedBox(height: 20),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Implement rating update functionality if needed
                          },
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Booking2(selectedDocID: selectedDocID!), // Pass both documentId and selectedDocID to Booking
                                ),
                              );
                            },
                            child: Text('Book'),
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


class Book3 extends StatelessWidget {
 
  final String? selectedDocID;

  const Book3({
    Key? key,
    required this.selectedDocID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedDocID == null) {
      // Handle the case where selectedDocID is null
      return Scaffold(
        body: Center(
          child: Text('Error: selectedDocID is null!'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Book Now', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users2').doc(selectedDocID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return Center(
                child: Card(
                color:Color.fromARGB(255, 233, 227, 244),
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
                        SizedBox(height: 20),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Implement rating update functionality if needed
                          },
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Booking3(selectedDocID: selectedDocID!), // Pass both documentId and selectedDocID to Booking
                                ),
                              );
                            },
                            child: Text('Book'),
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

class Book4 extends StatelessWidget {
 
  final String? selectedDocID;

  const Book4({
    Key? key,
    required this.selectedDocID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedDocID == null) {
      // Handle the case where selectedDocID is null
      return Scaffold(
        body: Center(
          child: Text('Error: selectedDocID is null!'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
        title: Text('Book Now', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('electrical').doc(selectedDocID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return Center(
                child: Card(
                  color:Color.fromARGB(255, 233, 227, 244),
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    
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
                        SizedBox(height: 20),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Implement rating update functionality if needed
                          },
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Booking4(selectedDocID: selectedDocID!), // Pass both documentId and selectedDocID to Booking
                                ),
                              );
                            },
                            child: Text('Book'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(50, 50),
                              
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

