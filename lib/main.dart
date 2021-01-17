import 'package:flutter/material.dart';
// import 'dart:developer' as developer;
// import 'components/board.dart';
// import 'pages/gameplay.dart';
import 'pages/welcome.dart';

// Kick off the application
void main() {
  runApp(LightBurst());
}

// We start with a stateless widget - that
// launches a "Material App" -- and displays
// Welcome as our "homepage".

class LightBurst extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LightBurst',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Welcome(),
      //Game(title: 'LightBurst'),
    );
  }
}