
import 'package:fix_it/home_page.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showUserDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Fix it',
          style: TextStyle(color: Colors.white), // Text color set to white
        ),
        backgroundColor: Color(0xFF00030E), // Same color as splash page
      ),
      backgroundColor: Color(0xFF00030E), // Same color as splash page
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showUserDetails ? UserDetails() : WorkerOrCustomerPage(onCustomerSelected: () {
            setState(() {
              showUserDetails = true;
            });
          }), // Show UserDetails if showUserDetails is true, otherwise show WorkerOrCustomerPage
        ],
      ),
    );
  }
}

class WorkerOrCustomerPage extends StatelessWidget {
  final VoidCallback onCustomerSelected;

  const WorkerOrCustomerPage({required this.onCustomerSelected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Sign up as',
            style: TextStyle(
              color: Colors.white, // Text color set to white
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle worker button pressed
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF2D46A0), // Button color set to 2D46A0
            ),
            child: Text(
              'Worker',
              style: TextStyle(color: Colors.white), // Text color set to white
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onCustomerSelected, // Call the callback function when the customer button is pressed
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF2D46A0), // Button color set to 2D46A0
            ),
            child: Text(
              'Customer',
              style: TextStyle(color: Colors.white), // Text color set to white
            ),
          ),
        ],
      ),
    );
  }
}



class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String selectedCountry = ''; // Variable to hold selected country

  @override
  Widget build(BuildContext context) {
    // List of states
    final List<String> states = ['State 1', 'State 2', 'State 3']; // Add all states here

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF00030E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: nameController,
            style: TextStyle(color: Color(0xFFBBBBBB)),
            decoration: InputDecoration(
              hintText: 'Name',
              hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBBBBBB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBBBBBB)),
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // Show country picker dialog
              showCountryPicker(
                showPhoneCode: false,
                context: context,
                onSelect: (Country country) {
                  setState(() {
                    selectedCountry = country.displayName;
                  });
                },
              );
            },
            child: AbsorbPointer(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Country',
                  hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFBBBBBB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFBBBBBB)),
                  ),
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                ),
                controller: TextEditingController(text: selectedCountry),
              ),
            ),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: null,
            decoration: InputDecoration(
              hintText: 'State',
              hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBBBBBB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBBBBBB)),
              ),
            ),
            items: states.map((String state) {
              return DropdownMenuItem<String>(
                value: state,
                child: Text(
                  state,
                  style: TextStyle(color: Color(0xFF434754)),
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              // Handle state selection
            },
          ),
          SizedBox(height: 10),
          TextField(
            controller: addressController,
            style: TextStyle(color: Color(0xFF434754)),
            decoration: InputDecoration(
              hintText: 'Location',
              hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBBBBBB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBBBBBB)),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: phoneNumberController,
            style: TextStyle(color: Color(0xFF434754)),
            decoration: InputDecoration(
              hintText: 'Phone Number',
              hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBBBBBB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFBBBBBB)),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle sign up button pressed
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF2D46A0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
