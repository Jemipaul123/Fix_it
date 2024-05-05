import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fix_it/home_page.dart';
import 'package:fix_it/services/cleaning.dart';

class GetUserName extends StatelessWidget {


  final String documentId;
  const GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {

CollectionReference users =FirebaseFirestore.instance.collection('users');


   return FutureBuilder<DocumentSnapshot>(
  future: users.doc(documentId).get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
     
      
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text('${data['first name']}' + ' ' + '${data['last name']}' +  '\n ' +'${data['job']}' +'\n ' +'${data['experience']}'  +'yrs' +'${data['location']}' ,style: TextStyle(color: Colors.black),);
     
    }
    return Text('Loading...');
  },
);
  }
}

class Getusers2 extends StatelessWidget {
  const Getusers2({required this.documentId});
  final String documentId;

  @override
  Widget build(BuildContext context) {
    CollectionReference users2 =FirebaseFirestore.instance.collection('users2');


   return FutureBuilder<DocumentSnapshot>(
  future: users2.doc(documentId).get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
     
      
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text('${data['first name']}' + ' ' + '${data['last name']}' +  '\n ' +'${data['job']}' +'\n ' +'${data['experience']}'   +'yrs' +'${data['location']}',style: TextStyle(color: Colors.black),);
     
    }
    return Text('Loading...');
  },
);
  }
}

class GetElectrical extends StatelessWidget {
  const GetElectrical({required this.documentId});
  final String documentId;

  @override
  Widget build(BuildContext context) {
    CollectionReference Electrical =FirebaseFirestore.instance.collection('electrical');


   return FutureBuilder<DocumentSnapshot>(
  future: Electrical.doc(documentId).get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
     
      
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text('${data['first name']}' + ' ' + '${data['last name']}' +  '\n ' +'${data['job']}' +'\n ' +'${data['experience']}'  +'yrs' +'${data['location']}' ,style: TextStyle(color: Colors.black),);
     
    }
    return Text('Loading...');
  },
);
  }
}


class GetGardening extends StatelessWidget {
  const GetGardening({required this.documentId});
  final String documentId;

  @override
  Widget build(BuildContext context) {
    CollectionReference Gardening =FirebaseFirestore.instance.collection('gardener');


   return FutureBuilder<DocumentSnapshot>(
  future: Gardening.doc(documentId).get(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
     
      
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text('${data['first name']}' + ' ' + '${data['last name']}' +  '\n ' +'${data['job']}' +'\n ' +'${data['experience']}'  +'yrs' +'${data['location']}' ,style: TextStyle(color: Colors.black),);
     
    }
    return Text('Loading...');
  },
);
  }
}


