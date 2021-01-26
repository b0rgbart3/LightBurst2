import 'package:flutter/material.dart';
import 'box.dart';
// import 'dart:math';
import '../model/sequence.dart';
import 'dart:developer' as developer;
import '../pages/gamewon.dart';
import '../model/settings.dart';
import '../classes/notifications.dart';
import '../classes/tileID.dart';

class Board extends StatefulWidget {
  Board({Key key, this.title}) : super(key: key);
  final String title;

  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {

 // int _counter = 0;
 // List boardList;
  List tileList;
  List keyList;
  bool tilesCreated = false;
  Settings mySettings = Settings();
  int sequenceLength;

  
@override
void initState() {
    super.initState();

  // Only set these Lists to empty if they haven't
  // already been created.
    // if (boardList == null) {
    //   boardList = [];
    // }
    if (tileList == null) {
      tileList = [];
    }
    if (keyList == null) {
      keyList = [];
     // clearBoard();
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
    mySettings.freshBoardList();
      clearBoard(true);
            }));
  }

  void clearBoard( fresh ) {

    tileList = [];
    keyList = [];
    tilesCreated = false;

    developer.log(mySettings.sequence.touches.toString());

  //  if (sequenceLength == null) {
      sequenceLength = mySettings.sequenceLength;
 //   }
     if (fresh) {
      mySettings.sequence.touches.forEach((tileID) {
        developer.log("touching");
       touchTile(tileID); }
    );
     }
  
  }
  
  // This is the main method that gets invoked when a box is touched.
  // So we need to toggle the tile, and it's neighbors, and update
  // the sequence -- because if this tile is not in the sequence,
  // then we need to add it to the sequence (the user just made it harder on 
  // themselves )

  void touchTile( tileID ) {
    //developer.log("In TouchTile: " + tileID.toString());
   // var index = tileID['row'] * tileCount + tileID['col'];
    // developer.log('Index: ' + index.toString());
    toggleTile( tileID );

   if (tilesCreated) {
     mySettings.sequence.checkForRemovals(tileID);
   }

    //above
    var above = tileID['row'] -1;
    if (above >= 0) { 
     //developer.log("above tile");
     toggleTile(  {'row': above, 'col':  tileID['col'] });
    }
     //below
    var below = tileID['row'] +1;
    if (below < mySettings.boardSize) { 
      //developer.log("below tile");
      toggleTile(  {'row': below, 'col':  tileID['col'] });
    }

    //left
    var left = tileID['col'] -1;
    if (left >= 0) { 
     // developer.log("left tile");
     toggleTile(  {'row': tileID['row'], 'col':  left});
    }
     //right
    var right = tileID['col'] + 1;
    if (right < mySettings.boardSize) { 
    //  developer.log("right tile");
          toggleTile(  {'row': tileID['row'], 'col':  right});
    }


    var alreadyExists = mySettings.sequence.updateSequence(tileID);
    if (alreadyExists == -1) {
      // setState(() {
      //   updateBoxes();
      // });
      var tileIndex = tileID["row"]*mySettings.boardSize + tileID["col"];
      keyList[tileIndex].currentState.toggleReveal();
//      keyList[tileIndex].curentState.
    }
    
  //  developer.log("After touching, boardList: " + mySettings.boardList.toString());


  }

  void redrawTile( tileID) {
    var index = tileID['row'] * mySettings.boardSize + tileID['col'];

    keyList[index].currentState.toggleReveal();

  }
  void toggleTile( tileID ) {
     var index = tileID['row'] * mySettings.boardSize + tileID['col'];
     // developer.log('toggle index: ' + index.toString());

    mySettings.toggleTile(index);
    
        if (tilesCreated) {
         // mySettings.checkForRemoval(tileID);
     // developer.log(".....DISPATCHING CHANGE......");
      // ChangeNotification(myID: {tileID})..dispatch(context);
      // tileList[index].toggleMyself();
      // developer.log("keyList["+index.toString()+"] = " + keyList[index].toString());
      // developer.log("State: " +keyList[index].currentState.toString());
      
      keyList[index].currentState.toggleMe();
     // boardList[index] = !boardList[index];
      
     // developer.log("About to check for win.");
      checkForWin();
   }
    // mySettings.boardList = boardList;
    // if (tilesCreated) {
    //   // tileList[index].widget.toggleMe();
    // }
   // developer.log('Toggling: ' + index.toString());
   // developer.log(boardList.toString());
  }

  void updateBoxes() {

      for (var i = 0; i < mySettings.boardSize*mySettings.boardSize; i++) {
           // developer.log("In updateBoxes, keyList["+i.toString()+"]: " + keyList[i].toString());
        // I am toggling the reveal parameter of each box
        // twice -- not because I want the parameter to
        // change, but because I want to trigger the box
        // to redraw itself (to turn on the hinting).
        // That's why I am toggling them twice
        keyList[i].currentState.toggleReveal();
        keyList[i].currentState.toggleReveal();
     
      }
  }

void checkForWin() {
  bool won = true;
  for (var i = 0; i < mySettings.boardSize*mySettings.boardSize; i++) {
    if (mySettings.boardList[i]) {
      won = false;
      break;
    }
  }
  if (won) {
    gameWon();
  }
}

bool getCurrentState( tileID ) {
  var index = tileID['row'] * mySettings.boardSize + tileID['col'];

  return  mySettings.boardList[index];
  // developer.log("Board List: " + boardList.toString());
  // developer.log("Tile List: " + tileList.toString());

}
// Returns true if the values are "new".
// If the values are the same as before, we return false

  bool setNewValues() {
    // Note: I used to pass the values in as an object coming from the
    // Notifier.
    var settingsChanged = false;


    if (sequenceLength != mySettings.sequenceLength) {
      sequenceLength = mySettings.sequenceLength;
      settingsChanged = true;
    }
    return settingsChanged;
  }


  @override
  Widget build(BuildContext context) {

    // developer.log("BUILDING BOARD.");
    //developer.log(boardList.toString());
    return NotificationListener<TouchNotification> (
      onNotification: (notification) {
       // developer.log('Got notified: ' + notification.myID.toString());
        touchTile(notification.myID);
        //var onState = getCurrentState(notification.myID);
        // We only want to check for removal if the the user is touching
        // the tile - not the app
        // if (tilesCreated && (onState==false)) {
        //   var thisTile = notification.myID;
        //    //var tileIndex = thisTile["row"]*tileCount + thisTile["col"];

        //    developer.log("notification ID: " + notification.myID.toString());
        //  // developer.log("About to check: " + tileIndex.toString());
        //   var removed = mySettings.sequence.checkForRemovals( notification.myID );
        //   if (removed) {
        //     redrawTile(notification.myID);
        //   }
          
        // }
        return true;
      },
      child:buildRows() );
  }

  Widget buildRows() {


    List rows = <Widget>[];

    for (var i = 0; i < mySettings.boardSize; i++) {
      rows.add(buildRow(i));
    }
    return Column(children: rows);
  }

  Widget buildRow(rowNum) {
    double screenSize = MediaQuery.of(context).size.width - 20.0;
    double tileSize = screenSize / mySettings.boardSize;


    List tiles = <Widget>[];

      if (mySettings.boardList.length < 1) {

        if (mySettings.boardList.length <= 0) {
          {

            mySettings.freshBoardList();
            clearBoard(true);
        }
      }
      }
// Dynamically build a whole row of tiles
    for (var i = 0; i < mySettings.boardSize; i++) {
     var thisIndex = rowNum*mySettings.boardSize + i;

     var revealThisBox = false;
     if (mySettings.sequence.fullSequenceIndexes.indexOf(thisIndex) != -1) {
       revealThisBox = true;
     }
      
    Key key = GlobalKey();
  

      var box = Box(key, tileSize, rowNum, i, mySettings.boardList[rowNum * mySettings.boardSize + i], revealThisBox);
      tiles.add(box);
      tileList.add(box);
      keyList.add(key);
   
  }
 tilesCreated = true;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: tiles);
  // void updateBoard(boxState, rowNum, colNum) {
  //   var index = rowNum * tileCount + colNum;
  //   boardList[index] = !boardList[index];

  // }
  }

}