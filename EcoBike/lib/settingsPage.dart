import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class StarryBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      painter: StarrySkyPainter(),
    );
  }
}

class StarrySkyPainter extends CustomPainter {
  final Random _random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint starPaint = Paint()..color = Colors.white;

    for (int i = 0; i < 150; i++) { // Generate 150 stars
      double x = _random.nextDouble() * size.width;
      double y = _random.nextDouble() * size.height;
      double radius = _random.nextDouble() * 2 + 1; // Vary star sizes

      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _SettingsPageState extends State<SettingsPage> {
  double progress = 0.3; // Initial progress
  ui.Image? earthImage; // Store the loaded image
  int _clickCount = 0; // Variable to track the number of taps

  @override
  void initState() {
    super.initState();
    _loadLitterPickup();
    _loadProgress();
    _loadEarthImage(); // Load the earth image once when the page is initialized
  }

  void _saveLitterPickup() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('litterPickup', _clickCount);
  }

  void _loadLitterPickup() async {
    final prefs = await SharedPreferences.getInstance();
    _clickCount = prefs.getInt('litterPickup')??0;
  }
  void _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('progress', progress);
  }

  void _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    progress = prefs.getDouble('progress')??0;
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
      _saveProgress();
      if (progress > 1.0) progress = 0.0; // Reset after full progress
      _clickCount++; // Increment the click count when the button is pressed
      _saveLitterPickup();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container( // Ensure background is visible
            color: Colors.black, // Set a default background color
            child: StarryBackground(),
          ),
        ),
        Center( // UI components
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: increaseProgress,
                child: earthImage == null
                    ? CircularProgressIndicator()
                    : CustomPaint(
                  size: Size(150, 150),
                  painter: EarthMeterPainter(progress, earthImage!),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Litter Picked Up: $_clickCount times',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), // Ensure text is visible
              ),
              Text(
                'Minutes of free bike: ${_clickCount * 5} times',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );


  }
}

class EarthMeterPainter extends CustomPainter {
  final double progress;
  final ui.Image earthImage;

  EarthMeterPainter(this.progress, this.earthImage);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = size.width / 2;

    // Scale the Earth Image to Fit Inside the Button
    final Rect earthRect = Rect.fromCircle(center: center, radius: radius);
    final Paint earthPaint = Paint()
      ..shader = ImageShader(
          earthImage,
          TileMode.clamp,
          TileMode.clamp,
          Matrix4.identity()
              .scaled(
            size.width / earthImage.width, // Scale width
            size.height / earthImage.height, // Scale height
          )
              .storage);

    // Circular Border Paint
    final Paint borderPaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Progress Arc Paint
    final Paint progressPaint = Paint()
      ..color = Colors.lightGreenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // Draw Earth Texture (Centered & Scaled)
    canvas.drawCircle(center, radius, earthPaint);

    // Draw Circular Border
    canvas.drawCircle(center, radius, borderPaint);

    // Draw Progress Arc (Around the Circle)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progress * 2 * pi,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
