import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import '../model/settings.dart';
import '../classes/notifications.dart';
import '../pages/info.dart';
import '../pages/settingseditor.dart';
import '../pages/gamewon.dart';
import '../components/board.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';
import '../components/framer.dart';

class Game extends StatefulWidget {
  Game({Key key}) : super(key: key);
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  Settings _mySettings = Settings();
  Board    _thisGameBoard;
  int      _colorIndex;
  bool     _myStateGotChanged = false;
  Timer    _myTimer;
  bool     _revealSequence = false;
  double   _score; 


  void _freshGame() {
    _mySettings.freshBoardList();
    setState(() { });
  }

 void _checkForWin() {
    bool won = true;
    developer.log('Checking for win...');
    for (var i = 0; i < _mySettings.boardSize*_mySettings.boardSize; i++) {
      if (_mySettings.sequence.board[i]) {
        won = false;
        break;}
    }
    if (won) {_gotoGameWonPage();}
  }

  void _gotoGameWonPage() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameWon()))
        .then((value) => setState(() {

              _mySettings.freshBoardList();
              _mySettings.showSequence = false;

            }));
  }
  void _gotoInfoPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Info()))
        .then((value) => setState(() {
              _mySettings.showSequence = false;
              _revealSequence = false;
              setState(() {});
            }));
  }

  void _returnToWelcomePage() {
    Navigator.pop(context, _myStateGotChanged);
  }

  void _showSequence() {
    if (_myTimer != null) {
      _myTimer.cancel();
    }
    _mySettings.toggleShowSequence();
    setState(() {});

    if (_mySettings.showSequence) {
      _mySettings.decreaseScore(_mySettings.sequenceLength*50.0);
        _myTimer = Timer(Duration(seconds: 3), () {
       
              developer.log("timer up");
              _mySettings.toggleShowSequence();
              developer.log("show is now: " + _mySettings.showSequence.toString());
              _revealSequence = false;
              setState(() {
                _myTimer.cancel();
              });
      });
    }

 }



  void _determineChange(changed) {

    int requireNewBoard = (changed["changes"].indexOf("board"));
    int requireNewSeq = (changed["changes"].indexOf("sequence"));
    int requireColorChange = (changed["changes"].indexOf("color"));

    bool requireNew = (requireNewBoard != -1) || (requireNewSeq != -1);
    bool colorChange = (requireColorChange != -1);

    if (requireNew) {
      setState(() {
        _colorIndex = _mySettings.colorIndex;
        _myStateGotChanged = true;
        _mySettings.freshBoardList();
      });
    } else {
      if (colorChange) {
        setState(() {
          _colorIndex = _mySettings.colorIndex;
          _myStateGotChanged = true;
        });
      } 
    }
  }

  void _goToSettingsEditorPage() {

    Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsEditor()))
        .then((value) => _determineChange(value));
  }

  @override
  Widget build(BuildContext context) {
    _mySettings = Settings();
    _score = _mySettings.score;
    _mySettings.context = context;
    _revealSequence = _mySettings.showSequence;
    int _colorIndex = _mySettings.colorIndex;
    Board _thisGameBoard = Board();
    double _mySize = _mySettings.screenSize / 5.25;


    // Not sure if we need the Scaffold here or not - since we are not
    // using the appBar.  It's likely that we don't need it

    return Framer(
            Center(
              child:  Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                 // border: Border.all(color: _mySettings.myColorSet.background ),
                  ),
                  width:_mySettings.screenSize*1.1,
                  height: _mySettings.screenSize*1.5,
                  
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NotificationListener<TouchNotification> (
                        onNotification: (notification) {
                          developer.log('About to check for win');
                          _checkForWin();
                          setState(() {});
                            return true;
                          },
                    child: _thisGameBoard ),
                   // There is an empty boxtext here because I used to display some of the
                   // settings... and I might bring that back.
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          boxText("",
                              Colors.white, Colors.black)
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NavButton(
                              null,
                              _returnToWelcomePage,
                              "",
                              Icon(Icons.navigate_before,
                                  color: _mySettings.myColorSet.text,
                                  size: 64.0),
                              _mySize,
                              _mySize,
                              false, false),
                                         NavButton(
                              null,
                              _gotoInfoPage,
                              "",
                              Icon(Icons.help_outline,
                                  color: _mySettings.myColorSet.text,
                                  size: 44.0),
                              _mySize,
                              _mySize,
                              false, false),  
                  
                            NavButton(
                                  UniqueKey(),
                                  _showSequence,
                                  "",
                                  Icon(Icons.visibility,
                                      color: _mySettings.myColorSet.text,
                                      size: 44.0),
                                  _mySize,
                                  _mySize,
                                  _revealSequence, true),
                          NavButton(
                              null,
                              _freshGame,
                              "",
                              Icon(Icons.add,
                                  color: _mySettings.myColorSet.text,
                                  size: 54.0),
                              _mySize,
                              _mySize,
                              false, false),
                          NavButton(
                              null,
                              _goToSettingsEditorPage,
                              "",
                              Icon(Icons.settings,
                                  color: _mySettings.myColorSet.text,
                                  size: 40.0),
                              _mySize,
                              _mySize,
                              false, false),
                        ])
                  ],
                )
              ),
            )
          );
  }
}