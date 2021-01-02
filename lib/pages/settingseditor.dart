import '../components/interface.dart';
import 'package:flutter/material.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';
import 'package:hexcolor/hexcolor.dart';
import '../components/slider.dart';

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
    return settingsBox(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child:
      Container(
        child: Stack(
            children: [Align(child: subTitleText('BOARD SIZE')), SettingsSlider()]))
      )
    );
  }

  Widget sequenceLengthSetting() {
    return settingsBox(
Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        child: Stack(children: [
      Align(child: subTitleText('SEQUENCE LENGTH')),
      SettingsSlider()
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
                        boardSizeSetting(),
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
