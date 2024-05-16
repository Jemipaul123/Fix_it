import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fix_it/read_data/get_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../book1.dart';
class ElectricalPage extends StatefulWidget {
  const ElectricalPage({Key? key}) : super(key: key);

  @override
  State<ElectricalPage> createState() => _ElectricalPageState();
}

class _ElectricalPageState extends State<ElectricalPage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];
  Map<String, String> firstNameMap = {};
   String selectedDocID = ''; 
   
  @override
  void initState() {
    super.initState();
    getDocIdAndFirstName();
  }


  Future<void> getDocIdAndFirstName() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('electrical').get();
    setState(() {
      docIDs = snapshot.docs.map((doc) => doc.id).toList();
      firstNameMap =Map.fromIterable(snapshot.docs,
      key:(doc)=> doc.id,
      value: (doc) => doc.data()['location'].toString());
    });
  }
    void setSelectedDocID(String docID) {
    setState(() {
      selectedDocID = docID;
    });
  }

  void filterDocIds(String query){
    setState(() {
      if(query.isEmpty){
        docIDs =firstNameMap.keys.toList();
      }else{
        docIDs=firstNameMap.entries
        .where((entry) => entry.value.toLowerCase().contains(query.toLowerCase()))
        .map((entry) => entry.key)
        .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 70),
            Text(
              'Electrical Services Near Me',
              style: TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 20),
             TextField(
  decoration: InputDecoration(
    labelText: 'Search by location',
    labelStyle: TextStyle(color: const Color.fromARGB(255, 181, 179, 179)), // Label text style
    suffixIcon: Icon(Icons.search),
    filled: true,
    fillColor: Colors.white, // Light grey color for the text field
    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Adjust padding
    focusedBorder: OutlineInputBorder( // Border when the field is focused
      borderSide: BorderSide(color: Colors.grey[300]!), // Adjust border color
      borderRadius: BorderRadius.circular(8), // Adjust border radius
    ),
    enabledBorder: OutlineInputBorder( // Border when the field is not focused
      borderSide: BorderSide(color: Colors.grey[300]!), // Adjust border color
      borderRadius: BorderRadius.circular(8), // Adjust border radius
    ),
  ),
  style: TextStyle(color: Colors.black), // Text color inside the field
  onChanged: (value) {
    filterDocIds(value);
  },
),
           
            Expanded(
              child: docIDs.isEmpty
                  ? Center(
                      child: Text('Result not found',
                          style: TextStyle(color: Colors.black)))
                  : ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            color: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                             
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListTile(
                                  title: GetElectrical(documentId: docIDs[index]),
                                  subtitle: Text(
                                    'Additional Information',
                                    style: TextStyle(color:Colors.grey[800] ),
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
                                SizedBox(height: 10,),
                                SizedBox(
                                  height: 50, 
                                  width: 20,// Set the height to your desired value
                                  child: GestureDetector(
                                    onTap: () {
                                      setSelectedDocID(docIDs[index]); // Set selected doc ID
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Book4(selectedDocID: selectedDocID),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF9352fc),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
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
