import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fix_it/read_data/get_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../book1.dart'; // Import Book1 screen

class CleaningPage extends StatefulWidget {
  const CleaningPage({Key? key}) : super(key: key);

  @override
  State<CleaningPage> createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];
  Map<String, String> firstNameMap = {}; // Map to store document ID and first name
  String selectedDocID = ''; // Store the selected document ID

  @override
  void initState() {
    super.initState();
    getDocIdAndFirstName();
  }

  Future<void> getDocIdAndFirstName() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      docIDs = snapshot.docs.map((doc) => doc.id).toList();
      firstNameMap = Map.fromIterable(snapshot.docs,
          key: (doc) => doc.id,
          value: (doc) => doc.data()['first name'].toString());
    });
  }

  void setSelectedDocID(String docID) {
    setState(() {
      selectedDocID = docID;
    });
  }

  void filterDocIds(String query) {
    setState(() {
      if (query.isEmpty) {
        // If query is empty, show all users
        docIDs = firstNameMap.keys.toList();
      } else {
        // Filter document IDs based on first name
        docIDs = firstNameMap.entries
            .where((entry) =>
                entry.value.toLowerCase().contains(query.toLowerCase()))
            .map((entry) => entry.key)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00030E),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 70),
            Text(
              'Cleaning Services Near Me',
              style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.white), // Label text style
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[900], // Light grey color for the text field
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Adjust padding
                focusedBorder: OutlineInputBorder(
                  // Border when the field is focused
                  borderSide: BorderSide(color: Colors.grey[300]!),
                  // Adjust border color
                  borderRadius: BorderRadius.circular(8),
                  // Adjust border radius
                ),
                enabledBorder: OutlineInputBorder(
                  // Border when the field is not focused
                  borderSide: BorderSide(color: Colors.grey[300]!),
                  // Adjust border color
                  borderRadius: BorderRadius.circular(8),
                  // Adjust border radius
                ),
              ),
              style: TextStyle(color: Colors.white), // Text color inside the field
              onChanged: (value) {
                filterDocIds(value);
              },
            ),
            Expanded(
              child: docIDs.isEmpty
                  ? Center(
                      child: Text('Result not found',
                          style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            color: Color(0xFF1B2154),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListTile(
                                  title: GetUserName(documentId: docIDs[index]),
                                  subtitle: Text(
                                    'Additional Information',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.person,
                                        color: Color(0xFF00030E)),
                                  ),
                                  onTap: () {
                                    setSelectedDocID(docIDs[index]); // Store selected doc ID
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      // Implement rating update functionality if needed
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setSelectedDocID(docIDs[index]); // Set selected doc ID
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Book1(selectedDocID: selectedDocID),
                                        ),
                                      );
                                    },
                                    child: Text('Book'),
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 45, 70, 160),
                                      onPrimary: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
