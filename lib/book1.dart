import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Book1 extends StatelessWidget {
  final String documentId;
  const Book1({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Book Now',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
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
  radius: 36, // Adjust the radius of the CircleAvatar
  child: Icon(
    Icons.person,
    color: Color(0xFF00030E),
    size: 50, // Adjust the size of the Icon
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
                              // Add book functionality
                            },
                            child: Text('Book'),
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
