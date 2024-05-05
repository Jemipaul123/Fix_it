import 'package:fix_it/components/userdisplay.dart';
import 'package:flutter/material.dart';
import 'package:fix_it/home_page.dart'; // Import your home page file
import 'package:fix_it/worker/workerprofile.dart'; 
import 'package:fix_it/worker/workerpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';// Import your profile page file

class UserDrawer extends StatelessWidget {
  
   UserDrawer({Key? key}) : super(key: key);
  final currentUserUID = FirebaseAuth.instance.currentUser?.uid;
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 39, 38, 38),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Color.fromARGB(255, 39, 38, 38),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UserDisplay()),
              );
            },
          ),
        ],
      ),
    );
  }
}
