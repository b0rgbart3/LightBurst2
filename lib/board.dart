import 'package:flutter/material.dart';
import 'box.dart';
// import 'dart:math';
import 'sequence.dart';
import 'dart:developer' as developer;
import 'pages/gamewon.dart';



class Board extends StatefulWidget {
  Board({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {

 // int _counter = 0;
  List boardList = [];
  List tileList = [];
  List keyList = [];
  bool tilesCreated = false;
  int tileCount = 5;
  int sequenceLength = 8;
  Sequence _sequence;
  


@override
void initState() {
  super.initState();
  clearBoard();
}
  
  void gameWon() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameWon()))
        .then((value) => setState(() {
      // maybe set some state value here....
            }));
  }


  void clearBoard() {
    for (var i = 0; i < tileCount * tileCount; i++) {
      boardList.add(false);
    }
    developer.log("CREATING NEW SEQUENCE.");
    _sequence = new Sequence(sequenceLength, tileCount);
    _sequence.generateRandomSequence(sequenceLength);
    developer.log('SEQUENCE: ' + _sequence.touches.toString());
    //developer.log(boardList.toString());
    _sequence.touches.forEach((ID) => 
       touchTile(ID)
    );
  }
  void touchTile( tileID ) {
     developer.log("In TouchTile: " + tileID.toString());
    var index = tileID['row'] * tileCount + tileID['col'];
    // developer.log('Index: ' + index.toString());
    toggleTile( tileID );

    //above
    var above = tileID['row'] -1;
    if (above >= 0) { 
      developer.log("above tile is: " + above.toString());
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
     developer.log('toggle index: ' + index.toString());
    if (tilesCreated) {
      developer.log(".....DISPATCHING CHANGE......");
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

  @override
  Widget build(BuildContext context) {
    developer.log("REBUILDING BOARD.");
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
    developer.log("/// in buildRows: ///");
    List rows = <Widget>[];

    for (var i = 0; i < tileCount; i++) {
      rows.add(buildRow(i));
    }
    return Column(children: rows);
  }

  Widget buildRow(rowNum) {
    double boardSize = MediaQuery.of(context).size.width;
    double tileSize = boardSize / tileCount;

    List tiles = <Widget>[];

// Dynamically build a whole row of tiles
    for (var i = 0; i < tileCount; i++) {
     // developer.log("building.... boardlist item = " + boardList[rowNum * tileCount + i].toString());
      GlobalKey<BoxState> key = GlobalKey();
      var box = Box(key, tileSize, rowNum, i, boardList[rowNum * tileCount + i]);
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
