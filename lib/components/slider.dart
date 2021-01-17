import 'package:flutter/material.dart';
import '../components/interface.dart';
import 'box.dart';
// import 'dart:math';
import '../model/sequence.dart';
import 'dart:developer' as developer;
import '../pages/gamewon.dart';
import 'ball.dart';
import '../classes/notifications.dart';

class SettingsSlider extends StatefulWidget {
  SettingsSlider(
      {Key key,
      this.title,
      this.screenWidth,
      this.sliderID,
      this.min,
      this.max,
      this.current})
      : super(key: key);

  final String title;
  final double screenWidth;
  final String sliderID;
  final int min, max;
  int current;

  var myKey = UniqueKey();
  

  @override
  State createState() => SliderState();
}

class SliderState extends State<SettingsSlider> {
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(child: subTitleText(widget.title +": "+ widget.current.toString())),
      Padding(
          padding:
              EdgeInsets.only(top: 54.0, bottom: 40.0, left: 10.0, right: 10.0),
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
      NotificationListener<DragNotification>(
          onNotification: (notification) {
            // We get a notification message here -- 
            // and we let it bubble up to the settingsEditor...

            developer.log('Got notified: ' + notification.id.toString());
            
            // If the user is still dragging - then we interrupt the notification,
            // and don't let it buble up to the settings Editor.
            if (!notification.drop) {
              developer.log(notification.value.toString());
              setState(() {
                widget.current = notification.value;
              });
              return true;
            }
          },
          child: Ball(
              key: widget.myKey,
              screenWidth: widget.screenWidth - 82.0,
              sliderID: widget.sliderID,
              min: widget.min,
              max: widget.max,
              current: widget.current))
    ]);
  }
}
