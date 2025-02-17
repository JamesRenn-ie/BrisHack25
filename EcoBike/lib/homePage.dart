import 'dart:convert';

import 'package:eco_bike/backend_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eco_bike/settingsPage.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Earth Meter Button',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double progress = 0.3; // Initial progress
  ui.Image? earthImage; // Store the loaded image
  bool _isLocked = true; // Lock state
  int _clickCount = 0;
  double _bikePosition = -100; // Start off-screen

  void _loadLitterPickup() async {
    final prefs = await SharedPreferences.getInstance();
    _clickCount = prefs.getInt('litterPickup') ?? 0;
  }

  void _loadLocked() async {
    final prefs = await SharedPreferences.getInstance();
    _isLocked = prefs.getBool('litterPickup') ?? true;
  }

  void _saveLocked() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('litterPickup', _isLocked);
  }

  @override
  void initState() {
    super.initState();
    _loadEarthImage(); // Load image once
    _loadLitterPickup();
    _loadLocked();
  }

  Future<void> _loadEarthImage() async {
    final ByteData data = await rootBundle.load('assets/earth.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();

    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });

    earthImage = await completer.future;
    setState(() {}); // Update state when image is loaded
  }

  void increaseProgress() {
    setState(() {
      progress += 0.1;
      if (progress > 1.0) progress = 0.0; // Reset after full
    });
  }

  void _toggleLock() {
    setState(() {
      _isLocked = !_isLocked; // Toggle lock state
      _saveLocked();
      if (!_isLocked) {
        _startBikeAnimation(); // Start animation when unlocked
      }
    });
  }


  int prevState=0;
  int litterDetected = 0;

  void _startBikeAnimation() {
    if (_bikePosition == -100) { // Only move if at the start
      setState(() {
        _bikePosition = MediaQuery.of(context).size.width; // Move across the screen
      });

      // Reset bike after animation completes
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _bikePosition = -100; // Restart position
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // Animated Bike Moving
        AnimatedPositioned(
          duration: Duration(seconds: 3),
          left: _bikePosition,
          bottom: 50, // Keep bike at bottom
          child: Image.asset(
            'assets/bike.png', // Add your bike image in assets
            width: 100,
          ),
        ),

        // Main Content
        SingleChildScrollView(
          child: Column(
            children: [
              Divider(height: 13, thickness: 0),
              ListTile(
                title: Text(
                  'Stats',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(Icons.query_stats, color: Colors.white),
                subtitle: Column(
                  children: [
                    Text(
                      "Litter Picked Up: $_clickCount",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.green),
                    ),
                    Text(
                      "Money Saved: £${(_clickCount * 0.20).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.green),
                    ),
                  ],
                ),
              ),
              Divider(height: 100, thickness: 10, color: Colors.white),

              // Start Journey Button
              GestureDetector(
                onTap: _toggleLock,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  decoration: BoxDecoration(
                    color: _isLocked ? Colors.grey.withOpacity(0.8) : Colors.green.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isLocked ? Icons.lock : Icons.lock_open,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        _isLocked ? 'Start Journey' : 'End Journey',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

