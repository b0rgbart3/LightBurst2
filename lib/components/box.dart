import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../model/settings.dart';
import 'interface.dart';

class TouchNotification extends Notification {
  final Object myID;

  const TouchNotification({this.myID});
}

class ChangeNotification extends Notification {
  final Object myID;

  const ChangeNotification({this.myID});
}

class Box extends StatefulWidget {
  final key, tileSize, rowNum, colNum, initialState, reveal;

  Box(this.key, this.tileSize, this.rowNum, this.colNum, this.initialState, this.reveal);

  void toggleMyself() {}

  @override
  BoxState createState() => BoxState();
}

class BoxState extends State<Box> {
  double endSize;
  bool onState;
  Settings mySettings = Settings();
  

List boxChildren(myWidth, myColor, myShadowColor, myCenterColor, reveal) {
    List thisList = <Widget>[];
    Widget outerBox = Align(
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
                        );
    Widget innerBox = Align(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            width: myWidth * .75,
                            height: myWidth * .75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: myCenterColor,
                              // boxShadow: [
                              //   BoxShadow(
                              //       color: myShadowColor,
                              //       blurRadius: 5,
                              //       spreadRadius: 5),
                              // ],
                            ),
                          ),
                        );
    thisList.add(outerBox);
    thisList.add(innerBox);
    if (reveal) {
      thisList.add( boxText("this"));
    }
    return thisList;
  }
  @override
  void initState() {
    super.initState();
    endSize = widget.tileSize * .9;
    onState = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    var myColor, myShadowColor, myCenterColor;

    if (onState) {
      // myColor = Colors.blue[200];
      myColor = Color(0xff00aaff);
      //myShadowColor = Colors.blue[100];
      myShadowColor = Color(0x8800ccff);
      myCenterColor = Color(0x44ffffff);
    } else {
      //myColor = Colors.blue[800];
      myColor = Color(0xff004488);
      // myShadowColor = Colors.blue[900];
      myShadowColor = Color(0x44001122);
      myCenterColor = Color(0x33001122);
    }

    return Container(
        alignment: Alignment.center,
        width: widget.tileSize,
        height: widget.tileSize,
        child: GestureDetector(
            onTapDown: pressDown,
            onTapUp: pressUp,
            onTapCancel: pressCancel,
            child: TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: endSize),
                duration: Duration(milliseconds: 100),
                builder: (_, num myWidth, __) {
                  return NotificationListener<ChangeNotification>(
                      onNotification: (notification) {
                       // developer.log('Got notified of change: ' +
                        //    notification.myID.toString());
                        toggleMe();
                        return true;
                      },
                      child: Stack(children: boxChildren(myWidth, myColor, myShadowColor, myCenterColor, widget.reveal)));
                })));
  }

  void pressDown(details) {
    setState(() {
      endSize = widget.tileSize * .75;
    });
  }

  void pressCancel() {
    setState(() {
      endSize = widget.tileSize * .9;
    });
  }

  void pressUp(details) {
    TouchNotification(myID: {'row': widget.rowNum, 'col': widget.colNum})
      ..dispatch(context);
    setState(() {
      endSize = widget.tileSize * .9;
    });
  }

  void toggleMe() {
    setState(() {
      onState = !onState;
    });
  }
}
