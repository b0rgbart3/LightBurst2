import '../components/interface.dart';
import 'package:flutter/material.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingsEditor extends StatefulWidget {
  SettingsEditor({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State createState() => SettingsState();
}

class SettingsState extends State<SettingsEditor> {
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
  Widget ball() {
    return Container(
      height:50,
      width:24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:Colors.white  
      )
    );
  }

  Widget slider() {
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
        ball()
      ]

    );
  }

  Widget boardSizeSetting() {
    return settingsBox(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child:
      Container(
        child: Stack(
            children: [Align(child: subTitleText('BOARD SIZE')), slider()]))
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
      slider()
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
                    child: Column(
                      children: [
                        TitleText("SETTINGS"),
                        boardSizeSetting(),
                        sequenceLengthSetting(),
                        NavButton(null,_submitSettings,"",
                            Icon(Icons.done, size: 54.0, color: HexColor("#aa60c6f9")), 65.0, 65.0),
                      ],
                    )))
          ])
        ,

                  ]),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _submitSettings,
        //   tooltip: 'Increment',
        //   child: Icon(Icons.api),
        // )
      );
  }
}
