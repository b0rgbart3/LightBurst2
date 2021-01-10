import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'interface.dart';
import '../pages/gameplay.dart';
import '../classes/notifications.dart';
import '../classes/colorset.dart';


class Tile extends StatefulWidget {
  final key, id, textString, touchable;

  Tile(
       this.key, this.id, this.textString, this.touchable);

  // void toggleMyself() {}

  @override
  State createState() => TileState();
}

class TileState extends State<Tile> {
  double endSize;
  double endScale = .9;
  bool onState;
  double tileSize = 90.0;

  @override
  void initState() {
    super.initState();
    endSize = tileSize * .9;
    onState = false;
    if (widget.touchable) {
      onState= true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Colorset introColorSet = new Colorset(0);

    var myColor, myShadowColor, myCenterColor;

    if (widget.touchable) {
      onState= true;
    }
    if (onState) {
      // myColor = Color(0xff00aaff);
      // myShadowColor = Color(0x8800ccff);
      // myCenterColor = Color(0x44ffffff);
      myColor = Color(introColorSet.insideHi);
      myCenterColor = Color(introColorSet.outsideHi);
      myShadowColor = Color(introColorSet.shadowHi);

    } else {
      // myColor = Color(0xff004488);
      // myShadowColor = Color(0x44001122);
      // myCenterColor = Color(0x33001122);
       myColor = Color(introColorSet.inside);
      myCenterColor = Color(introColorSet.outside);
      myShadowColor = Color(introColorSet.shadow);
      
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
                tween: Tween(begin: 0.0, end: endScale),
                duration: Duration(milliseconds: 150),
                builder: (_, num myScale, __) {
                  return 
                  // NotificationListener<ChangeNotification>(
                  //     onNotification: (notification) {
                  //       developer.log('Got notified of change: ' +
                  //           notification.myID.toString());
                  //       toggleMe();
                  //       return true;
                  //     },
                    //  child: 
                    Transform.scale(
                      alignment: Alignment.center,
                      scale: myScale,
                      child:
                      Stack(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            width: endSize,
                            height: endSize,
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
                              width: endSize * .75,
                              height: endSize * .75,
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
                      )
                      );
                })));
  }

  void pressDown(details) {
    // developer.log('press down');
    setState(() {
      // endSize = tileSize * .75;
      endScale = .75;
    });
  }

  void pressCancel() {
    setState(() {
     // endSize = tileSize * .9;
     endScale = .9;
    });
  }

  void pressUp(details) {
   //  developer.log('press up');'
   if (widget.touchable) {
   // developer.log("dispatching touch notification.");
    PlayNotification(id: widget.id)..dispatch(context);
    // toggleMe();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => GamePlay()))
    //     .then((value) => setState(() {
    //       // this make is so that when we swipe right to get back to this welcome
    //       // screen, the tile will be in its original condition.
    //           onState = false;
    //         }));
   }
    setState(() {
     // endSize = tileSize * .9;
     endScale = .9;
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
    //  developer.log("turning myself off.");
    });
  }

  void toggleMe() {
    setState(() {
      if (widget.touchable) {
      onState = !onState;
    //  developer.log('toggling tile');
      }
    });
  }
}
