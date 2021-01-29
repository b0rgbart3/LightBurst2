import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:async';
import '../components/board.dart';
import '../components/interface.dart';
import '../classes/notifications.dart';
import 'settingseditor.dart';
import '../components/navbutton.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/settings.dart';
import '../pages/gamewon.dart';

class Game extends StatefulWidget {
  Game({Key key}) : super(key: key);
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _counter = 0;
  Key revealKey = UniqueKey();
  Settings mySettings = Settings();
  int oldBoardSize;
  int oldSequenceLength;
  int oldColorIndex, colorIndex;
  bool myStateGotChanged = false;
  Timer myTimer;
  var onState = true;
  bool revealSequence = false;
  var score; 
  var board;

  void _freshGame() {
    mySettings.freshBoardList();
    setState(() {
      _counter++;
    });
  }

void checkForWin() {
  bool won = true;
  for (var i = 0; i < mySettings.boardSize*mySettings.boardSize; i++) {
    if (mySettings.sequence.board[i]) {
      won = false;
      break;}
  }
  if (won) {gameWon();}
}

  void gameWon() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameWon()))
        .then((value) => setState(() {
          // clearBoard();
    mySettings.freshBoardList();

            }));
  }
  void helpScreen() {

  }

  void returnToWelcome() {
    Navigator.pop(context, myStateGotChanged);
  }

  _showSequence() {
    if (myTimer != null) {
      myTimer.cancel();
    }
    mySettings.toggleShowSequence();
    // board.currentState.updateBoxes();  // trigger the board to redraw itself
    // revealKey.currentState.toggleMe();  // turn the reveal button to the highlighted state
    setState(() {
      // boardKey.currentState.build(context);
    });

    if (mySettings.showSequence) {
      mySettings.decreaseScore(mySettings.sequenceLength*50.0);
        myTimer = Timer(Duration(seconds: 3), () {
       //  _showSequence();
       
       developer.log("timer up");
        mySettings.toggleShowSequence();
        developer.log("show is now: " + mySettings.showSequence.toString());
        revealSequence = false;
        setState(() {
          
           myTimer.cancel();
        });
      });
    }

 }



  _determineChange(changed) {

    int requireNewBoard = (changed["changes"].indexOf("board"));
    int requireNewSeq = (changed["changes"].indexOf("sequence"));
    int requireColorChange = (changed["changes"].indexOf("color"));

    bool requireNew = (requireNewBoard != -1) || (requireNewSeq != -1);
    bool colorChange = (requireColorChange != -1);

    if (requireNew) {
      setState(() {
        colorIndex = mySettings.colorIndex;
        myStateGotChanged = true;
        mySettings.freshBoardList();
      });
    } else {
      if (colorChange) {
        setState(() {
          colorIndex = mySettings.colorIndex;
          myStateGotChanged = true;
        });
      } 
    }
  }

  _settingsEditor() {
    oldBoardSize = mySettings.boardSize;
    oldSequenceLength = mySettings.sequenceLength;
    oldColorIndex = mySettings.colorIndex;

    Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsEditor()))
        .then((value) => _determineChange(value));
  }

  @override
  Widget build(BuildContext context) {
    var mySettings = Settings();
    var sensitivity = 8;
    score = mySettings.score;

    mySettings.context = context;
    revealSequence = mySettings.showSequence;

    colorIndex = mySettings.colorIndex;
    oldColorIndex = colorIndex;

    // We only need to create a board if it hasn't already been created.
    //if (!mySettings.boardCreated) {

    board = Board();

    //}

    // Not sure if we need the Scaffold here or not - since we are not
    // using the appBar.  It's likely that we don't need it

    return Scaffold(
        // appBar: AppBar(
        //   // Here we take the value from the MyHomePage object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title: Text(widget.title),
        // ),
        key: UniqueKey(),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Note: Sensitivity is integer used when you don't want to mess up vertical drag
            // developer.log(details.delta.dx.toString());
            if (details.delta.dx > sensitivity) {
              // Right Swipe
              returnToWelcome();
            } else if (details.delta.dx < -sensitivity) {
              //Left Swipe
              _settingsEditor();
            }
          },
          child: Container(

              // color: Colors.blue[900],
              child: Stack(children: [
            // Image.asset('images/bkg1.jpg'),
            BkgImageWidget(),
            // ColorFilterWidget(),
            Center(
              child:  Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                  border: Border.all(color: mySettings.myColorSet.background ),
                  ),
                  width:mySettings.screenSize*1.1,
                  height: mySettings.screenSize*1.5,
                  
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NotificationListener<TouchNotification> (
                        onNotification: (notification) {
                          checkForWin();
                          setState(() {
          
                             });
                            return true;
                          },
                    child: board )

                   ,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          boxText(
                              "SL: " +
                                  mySettings.sequenceLength.toString() +
                                  // ", CS: " +
                                  // colorIndex.toString() + 
                                  ",  Score: "+score.toString(),
                              Colors.white,
                              Colors.black)
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NavButton(
                              null,
                              returnToWelcome,
                              "",
                              Icon(Icons.navigate_before,
                                  color: mySettings.myColorSet.text,
                                  size: 64.0),
                              65.0,
                              65.0,
                              false),
                                         NavButton(
                              null,
                              helpScreen,
                              "",
                              Icon(Icons.help_outline,
                                  color: mySettings.myColorSet.text,
                                  size: 44.0),
                              65.0,
                              65.0,
                              false),  
                  
                            NavButton(
                                  revealKey,
                                  _showSequence,
                                  "",
                                  Icon(Icons.visibility,
                                      color: mySettings.myColorSet.text,
                                      size: 44.0),
                                  65.0,
                                  65.0,
                                  revealSequence),
                          NavButton(
                              null,
                              _freshGame,
                              "",
                              Icon(Icons.add,
                                  color: mySettings.myColorSet.text,
                                  size: 54.0),
                              65.0,
                              65.0,
                              false),
                          NavButton(
                              null,
                              _settingsEditor,
                              "",
                              Icon(Icons.settings,
                                  color: mySettings.myColorSet.text,
                                  size: 40.0),
                              65.0,
                              65.0,
                              false),
                        ])
                  ],
                )
              ),
            )
          ])),
        ));
  }
}
