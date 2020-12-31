import '../components/interface.dart';
import 'package:flutter/material.dart';
import '../components/interface.dart';

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
          color: Colors.orange[800],
        ),
        child: contents)
    );
  }

  Widget slider() {
    return Padding(
        padding: EdgeInsets.only(top: 44.0, bottom:20.0),
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
        ));
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
                      ],
                    )))
          ])
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: _submitSettings,
          tooltip: 'Increment',
          child: Icon(Icons.api),
        ));
  }
}
