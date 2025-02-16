import 'package:eco_bike/profilePage.dart';
import 'package:eco_bike/settingsPage.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco-Bike',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Eco Bike'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 1; // Track which page is selected - initially, home page

  List<Widget> _pages = [];


  @override
  Widget build(BuildContext context) {
    _pages = [
      ProfilePage(),
      HomePage(),
      SettingsPage(),

    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,

          title: Text(
            "Eco Bike",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
             ),
            ),
        ),
        body: _pages[_selectedIndex],

    bottomNavigationBar: BottomNavigationBar(

      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: 'Find A Bike',
      ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
    ]
    ),
    );
  }

  // Allows user to switch between items on dock
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
