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
  int originalBoardSize, originalSequenceLength;

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

      Navigator.pop(context, changed );
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
          Align(child: subTitleText('BOARD SIZE: ' + boardSize.toString())),
          SettingsSlider(
              screenWidth: screenWidth, sliderID: "boardSize", min: mySettings.minBoardSize, max: mySettings.maxBoardSize, current: boardSize)
        ]))));
  }

  Widget sequenceLengthSetting() {
    double screenWidth = MediaQuery.of(context).size.width;

     return settingsBox(Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
            child: Stack(children: [
          Align(child: subTitleText('SEQUENCE LENGTH: ' + sequenceLength.toString())),
          SettingsSlider(
              screenWidth: screenWidth,
              sliderID: "sequenceLength",
              min: mySettings.minSequenceLength,
              max: mySettings.maxSequenceLength, current:sequenceLength)
        ]))));
  }

  @override
  Widget build(BuildContext context) {

    // Grab the values from our settings object
    boardSize = mySettings.boardSize;
    sequenceLength = mySettings.sequenceLength;

    if (originalBoardSize == null) {
      originalBoardSize = boardSize;
    }
    if (originalSequenceLength == null) {
      originalSequenceLength = sequenceLength;
    }

    return Scaffold(
      body: Column(children: [
        Stack(alignment: Alignment.center, children: [
          BkgImageWidget(),
          ColorFilterWidget(),
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
                          NotificationListener<DragNotification>(
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
                              child: boardSizeSetting()),
                         
                         NotificationListener<DragNotification>(
                           onNotification: (notification) {
                               // developer.log('Got notified: ' +
                                  //  notification.value.toString());
                                // update the boardSize value based on the notification
                                // that is coming from the ball getting dragged by the user
                                setState(() {
                                   sequenceLength = notification.value;
                                   mySettings.sequenceLength = sequenceLength;
                                });
                               
                                return true;
                              },
                           child:
                          sequenceLengthSetting()),
                          NavButton(
                              null,
                              _submitSettings,
                              "",
                              Icon(Icons.done,
                                  size: 54.0, color: HexColor("#aa60c6f9")),
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
