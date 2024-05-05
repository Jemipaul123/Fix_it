import 'package:fix_it/auth/auth.dart';
import 'package:fix_it/auth/login_or_register.dart';
import 'package:fix_it/components/userdrawer.dart';
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
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 227, 244),
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
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
      drawer: UserDrawer(),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Choose Your Service',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 40,),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                // Define the image asset paths for each service category
                List<String> imagePaths = [
                  'assets/images/janitor.png',
                  'assets/images/gardener.png',
                  'assets/images/plumber.png',
                  'assets/images/electrician.png',
                ];

                return GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CleaningPage()),
                        );
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GardeningPage()),
                        );
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlumberPage()),
                        );
                        break;
                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ElectricalPage()),
                        );
                        break;
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: index == 0
                          ? Color.fromARGB(255, 210, 202, 225)
                          : index == 1
                              ? Color.fromARGB(255, 210, 202, 225)
                              : index == 2
                                  ? Color.fromARGB(255, 210, 202, 225)
                                  : Color.fromARGB(255, 210, 202, 225),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              imagePaths[index],
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 10),
                            Text(
                              index == 0
                                  ? 'Cleaning'
                                  : index == 1
                                      ? 'Gardening'
                                      : index == 2
                                          ? 'Plumbing'
                                          : 'Electrical',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
