import 'package:flutter/material.dart';
// import 'dart:developer' as developer;
// import 'components/board.dart';
// import 'pages/gameplay.dart';
import 'pages/welcome.dart';

void main() {
  runApp(LightBurst());
}


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