import 'package:flutter/material.dart';
import 'box.dart';
// import 'dart:math';
import '../sequence.dart';
import 'dart:developer' as developer;
import '../pages/gamewon.dart';

class Ball extends StatefulWidget {
  Ball({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State createState() => BallState();
}

class BallState extends State<Ball> {

@override
void initState() {
  super.initState();
}
  
  bool tracking = false;
  double myX = 0;
  @override
  Widget build(BuildContext context) {


  void pressDown(details) {
    developer.log("pressDown:" + details.toString());
    setState(() {
      tracking = true;
    });
  }
  void letUp(details) {
    developer.log('letup:' + details.toString());
  }
  void trackMe(details) {
    developer.log('tracking:' + details.localOffsetFromOrigin.dx.toString());
    setState(() {
      myX = details.localOffsetFromOrigin.dx;
    });
  }
  void tapCancel() {
    developer.log('tapCancel:');
  }



    return Transform.translate(
      offset: Offset(myX,0),
      child:Padding(
      padding:EdgeInsets.symmetric(vertical:32.0, horizontal: 6.0),
      child: GestureDetector(
        onTapDown: pressDown,
        onTapUp: letUp,
        onLongPressMoveUpdate: trackMe,
        onTapCancel: tapCancel,
        child: Container(
      height:50,
      width:24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:Colors.blue[100]  
      )
    ))));
  }

}
