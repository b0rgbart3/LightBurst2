import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../components/board.dart';
import '../components/interface.dart';
import 'settingseditor.dart';
import '../components/navbutton.dart';
import 'package:hexcolor/hexcolor.dart';

class GamePlay extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    var sensitivity = 8;

  void returnToWelcome() {
      Navigator.pop(context);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LightBurst',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Note: Sensitivity is integer used when you don't want to mess up vertical drag
            // developer.log(details.delta.dx.toString());
            if (details.delta.dx > sensitivity) {
              // Right Swipe
              // developer.log("swipe right");
              returnToWelcome();
            } else if (details.delta.dx < -sensitivity) {
              //Left Swipe
              // developer.log("swipe left");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsEditor())).then((value) =>
                  // setState(() {
                  //   // this make is so that when we swipe right to get back to this welcome
                  //   // screen, the tile will be in its original condition.
                  //       onState = false;
                  //     })
                  developer.log('do something'));
            }
          },
          child: Game(title: 'LightBurst', returnToWelcome: returnToWelcome )),
    );
  }
}

class Game extends StatefulWidget {
  Game({Key key, this.title, this.returnToWelcome}) : super(key: key);
  final String title;
  final returnToWelcome;
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _counter = 0;

  void _freshGame() {
    setState(() {
      _counter++;
      boardKey.currentState.clearBoard();
      //board.currentState.clearBoard();
    });
  }


  void _settingsEditor() {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsEditor()))
        .then((value) => setState(() {
              // maybe set some state value here....
              //  developer.log("RE_SETTING STATE for BOARD");
              boardKey.currentState.clearBoard();
            }));
  }

  var onState = true;
  GlobalKey<BoardState> boardKey = GlobalKey();
  var board;

  @override
  Widget build(BuildContext context) {
    var board = Board(key: boardKey);

    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Container(
          color: Colors.blue[900],
          child: Stack(children: [
            // Image.asset('images/bkg1.jpg'),
            BkgImageWidget(),
            ColorFilterWidget(),
            Center(
              child: Padding( 
                 padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  board,
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavButton(
                            null,
                            widget.returnToWelcome,
                            "",
                            Icon(Icons.navigate_before,
                                color: HexColor("#aa60c6f9"), size: 54.0), 65.0, 65.0),
                        NavButton(
                            null,
                            _freshGame,
                            "",
                            Icon(Icons.add,
                                color: HexColor("#aa60c6f9"), size: 54.0), 65.0, 65.0),
                        NavButton(
                            null,
                            _settingsEditor,
                            "",
                            Icon(Icons.settings,
                                color: HexColor("#aa60c6f9"), size: 44.0), 65.0, 65.0),
                      ])
                ],
              ),
              ),
            )
          ])),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
