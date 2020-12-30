import '../components/interface.dart';
import 'package:flutter/material.dart';
// import '../components/interface.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  void _submitSettings() {
    setState(() {

    });
    Navigator.pop(context);
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
                    padding: EdgeInsets.symmetric(vertical: 100.0),
                    child: Column(
                      children: [
                        boxText("SETTINGS:"),
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
