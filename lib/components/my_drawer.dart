import 'package:flutter/material.dart';
import 'package:fix_it/home_page.dart'; // Import your home page file
import 'package:fix_it/worker/workerprofile.dart'; 
import 'package:fix_it/worker/workerpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';// Import your profile page file

class Drawer1 extends StatelessWidget {
  
   Drawer1({Key? key}) : super(key: key);
  final currentUserUID = FirebaseAuth.instance.currentUser?.uid;
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(219, 99, 68, 159),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Color.fromARGB(255, 141, 106, 205),
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
                MaterialPageRoute(builder: (context) => Worker1()),
              );
            },
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Workerprofile1()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Drawer2 extends StatelessWidget {
  
   Drawer2({Key? key}) : super(key: key);
  final currentUserUID = FirebaseAuth.instance.currentUser?.uid;
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blue,
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
                MaterialPageRoute(builder: (context) => Worker2()),
              );
            },
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Workerprofile2()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Drawer3 extends StatelessWidget {
  
   Drawer3({Key? key}) : super(key: key);
  final currentUserUID = FirebaseAuth.instance.currentUser?.uid;
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blue,
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
                MaterialPageRoute(builder: (context) => Worker3()),
              );
            },
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Workerprofile3()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Drawer4 extends StatelessWidget {
  
   Drawer4({Key? key}) : super(key: key);
  final currentUserUID = FirebaseAuth.instance.currentUser?.uid;
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blue,
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
                MaterialPageRoute(builder: (context) => Worker4()),
              );
            },
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Workerprofile4()),
              );
            },
          ),
        ],
      ),
    );
  }
}
