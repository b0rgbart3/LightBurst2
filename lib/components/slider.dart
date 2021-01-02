import 'package:flutter/material.dart';
import 'box.dart';
// import 'dart:math';
import '../sequence.dart';
import 'dart:developer' as developer;
import '../pages/gamewon.dart';
import 'ball.dart';
import '../classes/notifications.dart';

class SettingsSlider extends StatefulWidget {
  SettingsSlider({Key key, this.screenWidth, this.sliderID, this.min, this.max}) : super(key: key);

  final double screenWidth;
  final String sliderID;
  final int min, max;

var myKey = UniqueKey();
  @override
  State createState() => SliderState();
}

class SliderState extends State<SettingsSlider> {
  
 
@override
void initState() {
  super.initState();
 // developer.log("SCREEN WIDTH: " + widget.screenWidth.toString());
}

 

  @override
  Widget build(BuildContext context) {

 
    return Stack(
      children: [
      Padding(
        padding: EdgeInsets.only(top: 54.0, bottom:40.0, left:10.0, right:10.0),
        child: Container(
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                  color: Colors.blue[200], blurRadius: 5, spreadRadius: 5),
            ],
          ),
        )),
        NotificationListener<DragNotification> (
      onNotification: (notification) {
        // We get a notification message here -- but we don't respond to it -
        // we let it bubble up to the settingsEditor... 
        
        // developer.log('Got notified: ' + notification.id.toString());
       // return true;
      },
      child:
        Ball( key: widget.myKey, screenWidth:widget.screenWidth-82.0, sliderID: widget.sliderID, min: widget.min, max: widget.max )
        )
      ]

    );
  }

}
