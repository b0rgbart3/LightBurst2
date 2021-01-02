import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'interface.dart';
import '../pages/gameplay.dart';
import '../classes/notifications.dart';


class NavButton extends StatefulWidget {
  final key, id, textString;

  NavButton(
       this.key, this.id, this.textString);

  // void toggleMyself() {}

  @override
  State createState() => NavButtonState();
}

class NavButtonState extends State<NavButton> {
  double endSize;
  bool onState;
  double tileSize = 90.0;

  @override
  void initState() {
    super.initState();
    endSize = tileSize * .9;
    onState = false;

  }

  @override
  Widget build(BuildContext context) {
    var myColor, myShadowColor, myCenterColor;


    if (onState) {
      myColor = Color(0xff00aaff);
      myShadowColor = Color(0x8800ccff);
      myCenterColor = Color(0x44ffffff);
    } else {
      myColor = Color(0xff004488);
      myShadowColor = Color(0x44001122);
      myCenterColor = Color(0x33001122);
    }

    return Container(
        alignment: Alignment.center,
        width: tileSize,
        height: tileSize,
        child: GestureDetector(
            onTapDown: pressDown,
            onTapUp: pressUp,
            onTapCancel: pressCancel,
            child: TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: endSize),
                duration: Duration(milliseconds: 200),
                builder: (_, num myWidth, __) {
                  return 
                  // NotificationListener<ChangeNotification>(
                  //     onNotification: (notification) {
                  //       developer.log('Got notified of change: ' +
                  //           notification.myID.toString());
                  //       toggleMe();
                  //       return true;
                  //     },
                    //  child: 
                      Stack(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            width: myWidth,
                            height: myWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: myColor,
                              boxShadow: [
                                BoxShadow(
                                    color: myShadowColor,
                                    blurRadius: 5,
                                    spreadRadius: 5),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Stack(children: [
                            Container(
                              alignment: Alignment.center,
                              width: myWidth * .75,
                              height: myWidth * .75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: myCenterColor,
                              ),
                            ),
                          ]),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: boxText(widget.textString))
                      ]
                      //)
                      );
                })));
  }

  void pressDown(details) {
    // developer.log('press down');
    setState(() {
      endSize = tileSize * .75;
    });
  }

  void pressCancel() {
    setState(() {
      endSize = tileSize * .9;
    });
  }

  void pressUp(details) {
   //  developer.log('press up');'
 
   developer.log("dispatching touch notification.");
    PlayNotification(id: widget.id)..dispatch(context);
    // toggleMe();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => GamePlay()))
    //     .then((value) => setState(() {
    //       // this make is so that when we swipe right to get back to this welcome
    //       // screen, the tile will be in its original condition.
    //           onState = false;
    //         }));
   //}
    setState(() {
      endSize = tileSize * .9;
    });
  }

  void turnOn() {
    setState(() {
      onState = true;
    });
  }

  void turnOff() {
    setState(() {
      onState = false;
    });
  }

  void toggleMe() {
    setState(() {
 
      onState = !onState;
      developer.log('toggling tile');
      }
    );
  }
}