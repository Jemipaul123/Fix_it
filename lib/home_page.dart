import 'package:flutter/material.dart';
import 'package:fix_it/services/cleaning.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
              // Add navigation to gardening page
            },
            child: Text('Gardening'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add navigation to plumbing page
            },
            child: Text('Plumbing'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add navigation to electrical page
            },
            child: Text('Electrical'),
          ),
        ],
      ),
    );
  }
}

