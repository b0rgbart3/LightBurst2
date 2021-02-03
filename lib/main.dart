import 'package:flutter/material.dart';
import 'pages/welcome.dart';

// LIGHTBURST
// (c) Copyright 2020 by Bart Dority
//
//
// This game and the related code are 
// copyrighted (c) by Bart Dority, 2021,
//  all rights are reserved.  

// Please contact bartdority@gmail.com 
// if you would like to use any part 
// of the code or game design.  Thank you.
// 


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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Welcome(),
    );
  }
}