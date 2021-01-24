
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// ColorSets are my static pre-defined sets of 4 colors 
// the instantiated colorset will split those up into named variables

class Colorset {

  Color inside,outside,shadow,text,textShadow, background,insideHi,outsideHi, shadowHi, textHi, textShadowHi;

  static const colorsets = [
    // inside      //outside    //shadow     //text        //textShadow    //background
    [0xFF084F96,0xFF0E3F70,0xE0061F39,0xff33ccff, 0xff000000,  0x8E006BA4,
     0xAF5DC9FF,0xFF26A5DB,0x8800ccff,0xffffffff, 0xFF071625],
    [0xFF08963C,0xFF0E703D,0xE0063921,0xFFA1FFBC, 0xFF00180F, 0x720F6D35,
     0xAF6BFA93,0xFF26DB5F,0x8800FF66,0xffffffff, 0xFF072513],
    [0xFFDA0A41,0xFFA00428,0xB05A020F,0xFFFFDDE8, 0xFF6D001D, 0x88FF004C,
     0xFFFC86B9,0xFFFD4D8B,0xC8FF3C7A,0xFFFAC3C4, 0xFF6D001D]
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

    // inside = HexColor(colors[0].toString());
    // outside = HexColor(colors[1].toString());
    // shadow = HexColor(colors[2].toString());
    // text = HexColor(colors[3].toString());
    // textShadow = HexColor(colors[4].toString());
    // insideHi = HexColor(colors[5].toString());
    // outsideHi = HexColor(colors[6].toString());
    // shadowHi = HexColor(colors[7].toString());
    // textHi = HexColor(colors[8].toString());
    // textShadowHi = HexColor(colors[9].toString());

  }
//   String outside,inside,outsideHi,insideHi, outsideOff, insideOff;
//   List set;

//   static const colorssets = { 
//     "blue": ["#336cb3", "#34b7e8", "#44b7e8", "#54b7e8", "#002548", "#003e54"],
//     "red":  ["#cf1f25", "#ff1d58", "#ff5a7c", "#ff8888", "#6f0005", "#830023"],
//   };

//     // if (onState) {
//     //   myColor = Color(0xff00aaff);
//     //   myShadowColor = Color(0x8800ccff);
//     //   myCenterColor = Color(0x44ffffff);
//     // } else {
//     //   myColor = Color(0xff004488);
//     //   myShadowColor = Color(0x44001122);
//     //   myCenterColor = Color(0x33001122);
//     // }

// // Our Constructor

//   Colorset( this.set ) {
//     outside = set[0];
//     inside = set[1];
//     outsideHi = set[2];
//     insideHi = set[3];
//     outsideOff = set[4];
//     insideOff = set[5];
//   }



}