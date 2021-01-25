import '../components/interface.dart';
import 'package:flutter/material.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';
import 'package:hexcolor/hexcolor.dart';
import '../components/slider.dart';
import '../classes/notifications.dart';
import 'dart:developer' as developer;
import '../model/settings.dart';

class SettingsEditor extends StatefulWidget {
  SettingsEditor({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State createState() => SettingsEditorState();
}

class SettingsEditorState extends State<SettingsEditor> {

// returns our settings singleton
  Settings mySettings = Settings();  
  int boardSize;
  int sequenceLength;
  int colorIndex;
  int originalBoardSize, originalSequenceLength, originalColorIndex;
  int color, minColorIndex, maxColorIndex;

  void _submitSettings() {
      var changed = false;
      if (mySettings.sequenceLength != originalSequenceLength) {
      mySettings.sequenceLength = sequenceLength;
      changed = true;
      }
      if (mySettings.boardSize != originalBoardSize) {
      mySettings.boardSize = boardSize;
      changed = true;
      }
      if (mySettings.colorIndex != originalColorIndex) {
        mySettings.colorIndex = colorIndex;
        changed = true;
      }
      Navigator.pop(context, changed );
  }

  Widget boardSizeSlider() {
    return  NotificationListener<DragNotification>(
        onNotification: (notification) {
          //developer.log('Got notified: ' +
            //  notification.value.toString());
          // update the boardSize value based on the notification
          // that is coming from the ball getting dragged by the user
          setState(() {
              boardSize = notification.value;
              mySettings.boardSize = boardSize;
          });
          
          // return true;
        },
        child: boardSizeSetting());
  }

  Widget settingsBox(contents) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: contents));
  }

  Widget boardSizeSetting() {
    double screenWidth = MediaQuery.of(context).size.width;
    return settingsBox(Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
            child: Stack(children: [
          
          SettingsSlider(title:"BOARD SIZE",
              screenWidth: screenWidth, sliderID: "boardSize", min: mySettings.minBoardSize, max: mySettings.maxBoardSize, current: boardSize)
        ]))));
  }

  Widget sequenceLengthSlider() {
    return NotificationListener<DragNotification>(
        onNotification: (notification) {
            // update the sequenceLength value based on the notification
            // that is coming from the ball getting dragged by the user
            setState(() {
                sequenceLength = notification.value;
                developer.log("seq len: " + notification.value.toString());
                mySettings.sequenceLength = sequenceLength;
            });
            
            // return true;
          },
        child:
      sequenceLengthSetting());
  }



  Widget sequenceLengthSetting() {
    double screenWidth = MediaQuery.of(context).size.width;

     return settingsBox(Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
            child: Stack(children: [
  
          SettingsSlider(title: "SEQUENCE LENGTH",
              screenWidth: screenWidth,
              sliderID: "sequenceLength",
              min: mySettings.minSequenceLength,
              max: mySettings.maxSequenceLength, current:sequenceLength)
        ]))));
  }

  Widget colorSlider( editor, context) {
    return NotificationListener<DragNotification>(
        onNotification: (notification) {
            setState(() {
                colorIndex = notification.value;
                mySettings.colorIndex = colorIndex;
                developer.log("color changed" + colorIndex.toString());
                
            });
          },
        child: colorSetting());
  }
  
  Widget colorSetting() {
    double screenWidth = MediaQuery.of(context).size.width;

     return settingsBox(Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
            child: Stack(children: [
  
          SettingsSlider(title: "COLOR: " + colorIndex.toString(),
              screenWidth: screenWidth,
              sliderID: "color",
              min: mySettings.minColorIndex,
              max: mySettings.maxColorIndex, current:colorIndex)
        ]))));
  }

  @override
  Widget build(BuildContext context) {

    // Grab the values from our settings object
    boardSize = mySettings.boardSize;
    sequenceLength = mySettings.sequenceLength;
    colorIndex = mySettings.colorIndex;

    if (originalBoardSize == null) {
      originalBoardSize = boardSize;
    }
    if (originalSequenceLength == null) {
      originalSequenceLength = sequenceLength;
    }
    if (originalColorIndex == null) {
      originalColorIndex = colorIndex;
    }

    return Scaffold( key: UniqueKey(),
      body: Column(children: [
        Stack(alignment: Alignment.center, children: [
          BkgImageWidget(),
          // ColorFilterWidget(),
          Container(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Column(
                        children: [
                          TitleText("SETTINGS"),
                          boardSizeSlider(),
                          sequenceLengthSlider(),
                          colorSlider(this, context),
                          NavButton(
                              null,
                              _submitSettings,
                              "",
                              Icon(Icons.done,
                                  size: 54.0, color: mySettings.myColorSet.text),
                              65.0,
                              65.0, false),
                        ],
                      ))
          ))
        ]),
      ]),
    );
  }
}
