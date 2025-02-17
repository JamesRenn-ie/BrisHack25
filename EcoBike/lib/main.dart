import 'package:eco_bike/profilePage.dart';
import 'package:eco_bike/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'backend_bloc.dart';

import 'homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco-Bike',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => BackendBloc(),
        child: MyHomePage(title: 'EcoBike',),
      ),
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
              color :Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
             ),
          ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       BlocBuilder<BackendBloc, String>(
      //         builder: (context, state) {
      //           if (state.isEmpty) {
      //             return Text("Press the button to fetch data");
      //           }
      //           return Text(state);
      //         },
      //       ),
      //       const SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () {
      //           context.read<BackendBloc>().fetchData();
      //         },
      //         child: Text("Fetch Data"),
      //       ),
      //   ),
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
          icon: Icon(Icons.restore_from_trash),
          label: 'Litter Tracker',
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
