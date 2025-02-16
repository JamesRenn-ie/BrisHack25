import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/services.dart';

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
  ui.Image? mapImage;

  @override
  void initState() {
    super.initState();
    _loadEarthImage(); // Load image once
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              height: 13,
              thickness: 0,
            ),
            ListTile(
              title: Text('Stats',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  )),
              trailing: Icon(Icons.query_stats),
              subtitle: Column(
                children: [
                  Text(
                    "Litter Picked Up: 5",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Money Saved: £12",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                ],
              ),
            ),
            Divider(
              height: 50,
              thickness: 10,
            ),
            Column(
              children: [
                Text(
                  "Nearest Bike",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                ),
                Image.asset("assets/map.png"),
              ],
            ),
            Divider(
              height: 100,
              thickness: 10,
            ),
      ],
    ));
  }
}


