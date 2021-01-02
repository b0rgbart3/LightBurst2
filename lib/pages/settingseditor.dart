import '../components/interface.dart';
import 'package:flutter/material.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';
import 'package:hexcolor/hexcolor.dart';
import '../components/slider.dart';
import '../classes/notifications.dart';
import 'dart:developer' as developer;

class SettingsEditor extends StatefulWidget {
  SettingsEditor({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State createState() => SettingsEditorState();
}

class SettingsEditorState extends State<SettingsEditor> {
  void _submitSettings() {
    setState(() {});
    Navigator.pop(context);
  }

  Widget settingsBox(contents) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: contents)
    );
  }
  

  Widget boardSizeSetting() {
    double screenWidth = MediaQuery.of(context).size.width;
    return settingsBox(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child:
      Container(
        child: Stack(
            children: [Align(child: subTitleText('BOARD SIZE')), SettingsSlider(screenWidth: screenWidth, sliderID:"boardSize", min:4, max:8)]))
      )
    );
  }

  Widget sequenceLengthSetting() {
    double screenWidth = MediaQuery.of(context).size.width;
    return settingsBox(
Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        child: Stack(children: [
      Align(child: subTitleText('SEQUENCE LENGTH')),
      SettingsSlider(screenWidth: screenWidth, sliderID:"sequenceLength", min:4, max:8)
    ]))
    )
    );
  }

  @override
  Widget build(BuildContext context) {

    

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
                       padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                      child: Column(
                      children: [
                        TitleText("SETTINGS"),
                        NotificationListener<DragNotification> (
      onNotification: (notification) {
         developer.log('Got notified: ' + notification.id.toString());
          return true;
      },
      child:
                        boardSizeSetting() ),

                        
                        sequenceLengthSetting(),
                        NavButton(null,_submitSettings,"",
                            Icon(Icons.done, size: 54.0, color: HexColor("#aa60c6f9")), 65.0, 65.0),
                      ],
                    ))))
          ])
        ,

                  ]),

      );
  }
}
