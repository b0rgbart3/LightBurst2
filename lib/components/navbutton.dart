import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'interface.dart';
import '../pages/gameplay.dart';
import '../classes/notifications.dart';

// This widget is my custom navigation button widget
// It produces a square button for icon navigation
// and a horizontal rectangle for text navigation

class NavButton extends StatefulWidget {
  final key, onPressed, textString, icon;
  double navWidth, navHeight;
  bool onState;

  NavButton(this.key, this.onPressed, this.textString, this.icon, this.navWidth,
      this.navHeight, this.onState);

  @override
  State createState() => NavButtonState();
}

class NavButtonState extends State<NavButton> {
  double endWidth, endHeight;
  double endScale = .9;
  bool onState;
  double tileWidth,
      tileHeight,
      innerBoxHeightPercentage,
      innerBoxWidthPercentage;

  @override
  void initState() {
    super.initState();
    tileWidth = widget.navWidth;
    tileHeight = widget.navHeight;

    endWidth = tileWidth * .9;
    endHeight = tileHeight * .9;
    onState = widget.onState;

    if (widget.textString == "") {
      innerBoxWidthPercentage = .95;
      innerBoxHeightPercentage = .9;
    } else {
      innerBoxWidthPercentage = .91;
      innerBoxHeightPercentage = .88;
    }
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

    Widget buttonChild() {
      if (widget.textString != "") {
        return boxText(widget.textString);
      } else {
        return widget.icon;
      }
    }

    return Container(
        alignment: Alignment.center,
        width: tileWidth,
        height: tileHeight,
        child: GestureDetector(
            onTapDown: pressDown,
            onTapUp: pressUp,
            onTapCancel: pressCancel,
            child: TweenAnimationBuilder(
                tween: Tween(begin: 0.75, end: endScale),
                duration: Duration(milliseconds: 40),
                builder: (_, num percentage, __) {
                  return Transform.scale( scale: percentage, child: Stack(children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        width: endWidth,
                        height: endHeight,
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
                          width:
                              endWidth * innerBoxWidthPercentage,
                          height:
                              endHeight * innerBoxHeightPercentage,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: myCenterColor,
                          ),
                        ),
                      ]),
                    ),
                    Align(alignment: Alignment.center, child: buttonChild() )
                  ]
                      //)
                      )
                      );
                })));
  }

  void pressDown(details) {
    // developer.log('press down');
    setState(() {
      // endWidth = tileWidth * .75;
      // endHeight = tileHeight * .75;
      endScale = .75;
    });
  }

  void pressCancel() {
    setState(() {
      // endWidth = tileWidth * .9;
      // endHeight = tileHeight * .9;
      endScale = .9;
    });
  }

  void pressUp(details) {
    widget.onPressed();

    setState(() {
      // endWidth = tileWidth * .9;
      // endHeight = tileHeight * .9;
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
    });
  }

  void toggleMe() {
    setState(() {
      onState = !onState;
     // developer.log('toggling tile');
    });
  }
}
