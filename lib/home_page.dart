import 'package:fix_it/auth/auth.dart';
import 'package:fix_it/auth/login_or_register.dart';
import 'package:fix_it/services/electrical.dart';
import 'package:fix_it/services/gardening.dart';
import 'package:fix_it/services/plumber.dart';
import 'package:flutter/material.dart';
import 'package:fix_it/services/cleaning.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_it/LoginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  void signOut(){
    FirebaseAuth.instance.signOut();
  }
  Widget build(BuildContext context) {
    return Scaffold(



      
      appBar: AppBar(
        title: Text('Home'),
        
      actions: [
       IconButton(
  onPressed: () {
    signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  },
  icon: Icon(Icons.logout),
),
      ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CleaningPage()),
              );
            },
            child: Text('Cleaning'),
          ),
          ElevatedButton(
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GardeningPage()),
              );
            },
            child: Text('Gardening'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlumberPage()),
              );
            },
            child: Text('Plumbing'),
          ),
          ElevatedButton(
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ElectricalPage()),
              );
            },
            child: Text('Electrical'),
          ),
        ],
      ),
    );
  }
}