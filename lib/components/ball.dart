import 'package:flutter/material.dart';
import 'box.dart';
// import 'dart:math';
import '../sequence.dart';
import 'dart:developer' as developer;
import '../pages/gamewon.dart';

class Ball extends StatefulWidget {
  Ball({Key key, this.screenWidth, this.min, this.max}) : super(key: key);
  final double screenWidth;
  final int min,max;

  @override
  State createState() => BallState();
}

class BallState extends State<Ball> {

 int myIntValue = 0;
 double ballWidth = 50.0;

@override
void initState() {
  super.initState();
}
  
  bool tracking = false;
  double myX = 0.0;
  double origin = 0.0;
  @override
  Widget build(BuildContext context) {


  void pressDown(details) {
    developer.log("pressDown:" + details.toString());
    setState(() {
      tracking = true;
      origin = myX;
    });
  }
  void letUp(details) {
   // developer.log('letup:' + details.toString());
    
  }
  void trackMe(details) {
  // developer.log('tracking:' + details.localOffsetFromOrigin.dx.toString());
    setState(() {

      myX = origin + details.localOffsetFromOrigin.dx;
      if (myX > ( widget.screenWidth)) {
        myX = widget.screenWidth;
      }
      if (myX < 0.0) {
        myX = 0.0;
      }

      var diff = widget.max - widget.min;
      myIntValue = ((( (myX + (ballWidth/2)) / (diff))/widget.max) / diff).round() + widget.min;
      developer.log("INT: " + myIntValue.toString());
     
    });
  }
  void tapCancel() {
   // developer.log('tapCancel:');
  }



    return Transform.translate(
      offset: Offset(myX,10.0),
      child:Padding(
      padding:EdgeInsets.symmetric(vertical:32.0, horizontal: 6.0),
      child: GestureDetector(
        onTapDown: pressDown,
        onTapUp: letUp,
        onLongPressMoveUpdate: trackMe,
        onTapCancel: tapCancel,
        child: Container(
      height:40,
      width:ballWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:Colors.blue[100]  
      )
    ))));
  }

}
