

// ColorSets are my static pre-defined sets of 4 colors 
// the instantiated colorset will split those up into named variables

class Colorset {

  num inside,outside,shadow,text,textShadow, insideHi,outsideHi, shadowHi, textHi, textShadowHi;

  static const colorsets = [
    // inside      //outside    //shadow     //text        //textShadow
    [0xFF084F96,0xFF0E3F70,0xE0061F39,0xff33ccff, 0xff000000,
     0xAF5DC9FF,0xFF26A5DB,0xff33ccff,0xffffffff, 0xFF071625],
    [0xffff1d58,0xffd01f25,0x66d01f25,0xffffffff, 0xff000000,
     0xffff8888,0xffff1d48,0x55ff1d48,0xffd01f25, 0xff000000]
  ];

  Colorset( colorID ) {
    var colors = colorsets[colorID];
    inside = colors[0];
    outside = colors[1];
    shadow = colors[2];
    text = colors[3];
    textShadow = colors[4];
    insideHi = colors[5];
    outsideHi = colors[6];
    shadowHi = colors[7];
    textHi = colors[8];
    textShadowHi = colors[9];

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