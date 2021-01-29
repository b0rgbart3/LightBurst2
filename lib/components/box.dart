import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../model/settings.dart';
import 'interface.dart';
import '../classes/notifications.dart';



class Box extends StatefulWidget {

  Box({Key key, this.index}) : super(key: key);
  final int index;

  @override
  BoxState createState() => BoxState();
}

class BoxState extends State<Box> {
  double endSize;
  bool onState;
  Settings mySettings = Settings();
  

List boxChildren(myWidth, myColor, myShadowColor, myCenterColor, index) {
   
    List thisList = <Widget>[];
    Widget outerBox = Align(
                          alignment: Alignment.center,
                          child: Padding(
        padding: EdgeInsets.symmetric(vertical: myWidth*.05, horizontal:myWidth*.05),
        child:Container(
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
                        ));
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
    if (mySettings.sequence.reveal(index) && mySettings.showSequence) {
      thisList.add( Align( alignment: Alignment.center, 
      child: 
      Container(
        width:30,
        height:30,
        decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black,
                              // boxShadow: [
                              //   BoxShadow(
                              //       color: myShadowColor,
                              //       blurRadius: 5,
                              //       spreadRadius: 5),
                              // ],
                            ),

      )
       ) );
    }
    return thisList;
  }
  @override
  void initState() {
    super.initState();
    endSize = mySettings.tileSize;
  }

  @override
  Widget build(BuildContext context) {
    var myColor, myShadowColor, myCenterColor;
    onState = mySettings.sequence.board[widget.index];

    if (onState) {
      // myColor = Colors.blue[200];
      myColor = Color(0xff00aaff);
      //myShadowColor = Colors.blue[100];
      myShadowColor = Color(0x8800ccff);
      myCenterColor = Color(0x44ffffff);
      myCenterColor= mySettings.myColorSet.insideHi;
      myColor = mySettings.myColorSet.outsideHi;
      myShadowColor = mySettings.myColorSet.shadowHi;
    } else {
      //myColor = Colors.blue[800];
      myColor = Color(0xff004488);
      // myShadowColor = Colors.blue[900];
      myShadowColor = Color(0x44001122);
      myCenterColor = Color(0x33001122);
      myCenterColor= mySettings.myColorSet.inside;
      myColor = mySettings.myColorSet.outside;
      myShadowColor = mySettings.myColorSet.shadow;
    }

    return Container(
        alignment: Alignment.center,
        width: mySettings.tileSize,
        height: mySettings.tileSize,
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
                      child: Stack(children: boxChildren(myWidth, myColor, myShadowColor, myCenterColor, widget.index)));
                })));
  }

  void pressDown(details) {
    setState(() {
      endSize = mySettings.tileSize * .75;
    });
  }

  void pressCancel() {
    setState(() {
      endSize = mySettings.tileSize * .9;
    });
  }

  void pressUp(details) {
    TouchNotification(myID: widget.index)
      ..dispatch(context);
    setState(() {
      endSize = mySettings.tileSize * .9;
      
    });
  }

  void toggleMe() {
    setState(() {
      onState = !onState;
    });
  }


}
