
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// ColorSets are my static pre-defined sets of 4 colors 
// the instantiated colorset will split those up into named variables

class Colorset {

  Color inside,outside,shadow,text,textShadow, background,insideHi,outsideHi, shadowHi, textHi, textShadowHi;
  String nameString;

  static const colorsets = [
    // inside      //outside    //shadow     //text        //textShadow    //background
    [0xFF084F96,0xFF0E3F70,0xE0061F39,0xFF8EE1FD, 0xff000000,  0x8E006BA4,
     0xAF5DC9FF,0xFF26A5DB,0x8800ccff,0xFFDCFEFB, 0xFF071625, "blue"],
    [0xFF08963C,0xFF0E703D,0xE0063921,0xFFA1FFBC, 0xFF00180F, 0x720F6D35,
     0xAF6BFA93,0xFF26DB5F,0x8800FF66,0xFFF5FFE6, 0xFF072513, "green"],
    [0xFFDA0A41,0xFFA00428,0xB05A020F,0xFFFFDDE8, 0xFF6D001D, 0x88FF004C,
     0xFFFC86B9,0xFFFD4D8B,0xC8FF3C7A,0xFFFAC3C4, 0xFF6D001D, "red"],
    [0xFFDA640A,0xFFA02E04,0xB05A1C02,0xFFF7D3AB, 0xFF6D2A00, 0x88FF7B00,
     0xFFFCCD86,0xFFFDAB4D,0xC8FF973C,0xFFF5C593, 0xFF6D3A00, "orange"]
  ];

  Colorset( colorID ) {
    var colors = colorsets[colorID];
    inside = Color(colors[0]);
    outside = Color(colors[1]);
    shadow = Color(colors[2]);
    text = Color(colors[3]);
    textShadow = Color(colors[4]);
    background = Color(colors[5]);
    insideHi = Color(colors[6]);
    outsideHi = Color(colors[7]);
    shadowHi = Color(colors[8]);
    textHi = Color(colors[9]);
    textShadowHi = Color(colors[10]);
    nameString = colors[11];


  }
  


}