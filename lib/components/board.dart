import 'package:flutter/material.dart';
import 'box.dart';
// import 'dart:math';
import '../model/sequence.dart';
import 'dart:developer' as developer;
import '../pages/gamewon.dart';
import '../model/settings.dart';

class Board extends StatefulWidget {
  Board({Key key, this.title}) : super(key: key);
  final String title;

  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {

 // int _counter = 0;
  List boardList = [];
  List tileList = [];
  List keyList = [];
  bool tilesCreated = false;
  Settings mySettings = Settings();
  int tileCount; 
  int sequenceLength;
  Sequence _sequence;

  
@override
void initState() {
  super.initState();
  clearBoard();
  if (tileCount==null) {
    tileCount = mySettings.boardSize;
  }
  if (sequenceLength == null) {
    sequenceLength = mySettings.sequenceLength;
  }
}
  
  void gameWon() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameWon()))
        .then((value) => setState(() {
      // maybe set some state value here....
    //  developer.log("RE_SETTING STATE for BOARD");
      clearBoard();
            }));
  }

  void clearBoard() {
    boardList = [];
    tileList = [];
    keyList = [];
    tilesCreated = false;
    if (tileCount==null) {
      tileCount = mySettings.boardSize;
    }
    if (sequenceLength == null) {
      sequenceLength = mySettings.sequenceLength;
    }
    for (var i = 0; i < tileCount * tileCount; i++) {
      boardList.add(false);
    }
   //  developer.log("CREATING NEW SEQUENCE.");
    _sequence = new Sequence(sequenceLength, tileCount);
    _sequence.generateRandomSequence(sequenceLength);
    developer.log('SEQUENCE: ' + _sequence.touches.toString());
    developer.log('Indexes: ' + _sequence.sequenceOfIndexes.toString());

    //developer.log(boardList.toString());
    _sequence.touches.forEach((tileID) => 
       touchTile(tileID)
    );
  }
  void touchTile( tileID ) {
    // developer.log("In TouchTile: " + tileID.toString());
   // var index = tileID['row'] * tileCount + tileID['col'];
    // developer.log('Index: ' + index.toString());
    toggleTile( tileID );

    //above
    var above = tileID['row'] -1;
    if (above >= 0) { 
    //  developer.log("above tile is: " + above.toString());
     toggleTile(  {'row': above, 'col':  tileID['col'] });
    }
     //below
    var below = tileID['row'] +1;
    if (below < tileCount) { 
      toggleTile(  {'row': below, 'col':  tileID['col'] });
    }

    //left
    var left = tileID['col'] -1;
    if (left >= 0) { 
     toggleTile(  {'row': tileID['row'], 'col':  left});
    }
     //right
    var right = tileID['col'] + 1;
    if (right < tileCount) { 
          toggleTile(  {'row': tileID['row'], 'col':  right});
    }
  }

  void toggleTile( tileID ) {
     var index = tileID['row'] * tileCount + tileID['col'];
     // developer.log('toggle index: ' + index.toString());
    if (tilesCreated) {
     // developer.log(".....DISPATCHING CHANGE......");
      // ChangeNotification(myID: {tileID})..dispatch(context);
      // tileList[index].toggleMyself();
      
      keyList[index].currentState.toggleMe();
      boardList[index] = !boardList[index];
      checkForWin();
   }
    else {
      boardList[index] = !boardList[index];
    }
    

    // if (tilesCreated) {
    //   // tileList[index].widget.toggleMe();
    // }
   // developer.log('Toggling: ' + index.toString());
   // developer.log(boardList.toString());
  }

void checkForWin() {
  bool won = true;
  for (var i = 0; i < tileCount*tileCount; i++) {
    if (boardList[i]) {
      won = false;
      break;
    }
  }
  if (won) {
    gameWon();
  }
}

// Returns true if the values are "new".
// If the values are the same as before, we return false

  bool setNewValues() {
    // Note: I used to pass the values in as an object coming from the
    // Notifier.
    var settingsChanged = false;

    if (tileCount != mySettings.boardSize) {
      tileCount = mySettings.boardSize;
      settingsChanged = true;
    }
    if (sequenceLength != mySettings.sequenceLength) {
      sequenceLength = mySettings.sequenceLength;
      settingsChanged = true;
    }
    return settingsChanged;
  }


  @override
  Widget build(BuildContext context) {

    //developer.log("REBUILDING BOARD.");
    // developer.log(boardList.toString());
    return NotificationListener<TouchNotification> (
      onNotification: (notification) {
        // developer.log('Got notified: ' + notification.myID.toString());
        touchTile(notification.myID);
        return true;
      },
      child:buildRows() );
  }

  Widget buildRows() {

    List rows = <Widget>[];

    for (var i = 0; i < tileCount; i++) {
      rows.add(buildRow(i));
    }
    return Column(children: rows);
  }

  Widget buildRow(rowNum) {
    double boardSize = MediaQuery.of(context).size.width - 20.0;
    double tileSize = boardSize / tileCount;

    List tiles = <Widget>[];

// Dynamically build a whole row of tiles
    for (var i = 0; i < tileCount; i++) {
     // developer.log("building.... boardlist item = " + boardList[rowNum * tileCount + i].toString());
     var thisIndex = rowNum*tileCount + i;
     var revealThisBox = false;
     if (mySettings.sequenceOfIndexes.indexOf(thisIndex) != -1) {
       revealThisBox = true;
     }
      var key = GlobalKey();
     // developer.log('Key: ' + key.toString());
      var box = Box(key, tileSize, rowNum, i, boardList[rowNum * tileCount + i], revealThisBox);
      tiles.add(box);
      tileList.add(box);
      keyList.add(key);
    }
    tilesCreated = true;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: tiles);
  }

  // void updateBoard(boxState, rowNum, colNum) {
  //   var index = rowNum * tileCount + colNum;
  //   boardList[index] = !boardList[index];

  // }
}
