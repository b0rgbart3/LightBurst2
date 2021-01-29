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

  var board;

  void _freshGame() {
    mySettings.freshBoardList();
    setState(() {
      _counter++;
    });
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
  //   if (_showSequence) {
   
  //     developer.log("_ShowSequence is true");

  //     var timer = Timer(Duration(seconds: 3), () { 
  //          developer.log("notify timer ending");
  //          _showSequence=false;
  //       TimerEndNotification(myID: false)
  //     ..dispatch(context);

  
   
  //     }
  //     );
 }



  _determineChange(changed) {
    //developer.log(changed.toString());
    // we get a boolean back from the Settings Editor
    // and Only if the settings have changed
    // do we need to call set State

    //developer.log("changed: " + changed.toString());
    // if ((mySettings.boardSize != oldBoardSize) || (mySettings.sequenceLength != oldSequenceLength)) {
    //   changed = true;
    // }
    //developer.log("Got back the changes: " +changed.toString());
    int requireNewBoard = (changed["changes"].indexOf("board"));
    int requireNewSeq = (changed["changes"].indexOf("sequence"));
    int requireColorChange = (changed["changes"].indexOf("color"));

    bool requireNew = (requireNewBoard != -1) || (requireNewSeq != -1);
    bool colorChange = (requireColorChange != -1);

    if (requireNew) {
      setState(() {
        //  var settingsChanged = boardKey.currentState.setNewValues();
        //if (settingsChanged) {
        // developer.log("old color index: " + oldColorIndex.toString());
        // boardKey.currentState.setState( () => {

        colorIndex = mySettings.colorIndex;
        myStateGotChanged = true;

        mySettings.freshBoardList();

        // }
      });
    } else {
      if (colorChange) {
        //  developer.log("The color was changed.");
        setState(() {
          //    // boardKey.currentState.clearBoard();
          colorIndex = mySettings.colorIndex;
          myStateGotChanged = true;

          // boardKey.currentState.clearBoard();
        });
      } else {
        // developer.log("There were no changes to the settings.");
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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    board,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          boxText(
                              "SL: " +
                                  mySettings.sequenceLength.toString() +
                                  ", CS: " +
                                  colorIndex.toString(),
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
                                  size: 54.0),
                              65.0,
                              65.0,
                              false),
                      
                  
                            NavButton(
                                  revealKey,
                                  _showSequence,
                                  "",
                                  Icon(Icons.visibility,
                                      color: mySettings.myColorSet.text,
                                      size: 54.0),
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
                                  size: 44.0),
                              65.0,
                              65.0,
                              false),
                        ])
                  ],
                ),
              ),
            )
          ])),
        ));
  }
}
