import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'time.dart'; // Import your time.dart file

class Booking1 extends StatefulWidget {
  final String selectedDocID; // Add a documentId property

  const Booking1({Key? key, required this.selectedDocID}) : super(key: key);

  @override
  State<Booking1> createState() => _Booking1State();
}

class _Booking1State extends State<Booking1> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking',style: TextStyle(fontWeight: FontWeight.bold),),
         backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
       backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Column(

        children: [
          SizedBox(height:40),
          Text("Selected Day is " + today.toString().split(" ")[0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          SizedBox(height:20),
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChooseTime1(selectedDocID: widget.selectedDocID)),
              );
            },
            child: Text('Choose a Time',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
class Booking2 extends StatefulWidget {
  final String selectedDocID; // Add a documentId property

  const Booking2({Key? key, required this.selectedDocID}) : super(key: key);

  @override
  State<Booking2> createState() => _Booking2State();
}

class _Booking2State extends State<Booking2> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
         backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
       backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Column(
        children: [
           SizedBox(height:40),
          Text("Selected Day is " + today.toString().split(" ")[0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          SizedBox(height:20),
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChooseTime2(selectedDocID: widget.selectedDocID)),
              );
            },
            child: Text('Choose a Time',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
class Booking3 extends StatefulWidget {
  final String selectedDocID; // Add a documentId property

  const Booking3({Key? key, required this.selectedDocID}) : super(key: key);

  @override
  State<Booking3> createState() => _Booking3State();
}

class _Booking3State extends State<Booking3> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
         backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
      backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Column(
        children: [
        SizedBox(height:40),
          Text("Selected Day is " + today.toString().split(" ")[0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          SizedBox(height:20),
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChooseTime3(selectedDocID: widget.selectedDocID)),
              );
            },
            child: Text('Choose a Time',style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}


class Booking4 extends StatefulWidget {
  final String selectedDocID; // Add a documentId property

  const Booking4({Key? key, required this.selectedDocID}) : super(key: key);

  @override
  State<Booking4> createState() => _Booking4State();
}

class _Booking4State extends State<Booking4> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
         backgroundColor: Color.fromARGB(255, 233, 227, 244),
      ),
       backgroundColor: Color.fromARGB(255, 233, 227, 244),
      body: Column(
        children: [
        SizedBox(height:40),
          Text("Selected Day is " + today.toString().split(" ")[0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          SizedBox(height:20),
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChooseTime4(selectedDocID: widget.selectedDocID)),
              );
            },
            child: Text('Choose a Time',style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}