import 'package:flutter/material.dart';
import 'box.dart';
// import 'dart:math';
import 'sequence.dart';
import 'dart:developer' as developer;



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
  int sequenceLength = 4;
  Sequence _sequence;
  


@override
void initState() {
  super.initState();
  clearBoard();
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
    // var above = tileID['row'] -1;
    // if (above >= 0) { 
    //   // developer.log(above.toString());
    //   toggleTile(  above * tileCount + tileID['col'] );
    //  }
    // //below
    // var below = tileID['row'] +1;
    // if (below < tileCount) { 
    //   toggleTile(  below * tileCount + tileID['col'] );
    // }

    // //left
    // var left = tileID['col'] -1;
    // if (left >= 0) { 
    //   toggleTile( tileID['row'] * tileCount + left );
    // }
    // //right
    // var right = tileID['col'] + 1;
    // if (right < tileCount) { 
    //   toggleTile( tileID['row']*tileCount + right );
    // }
  }

  void toggleTile( tileID ) {
     var index = tileID['row'] * tileCount + tileID['col'];
    if (tilesCreated) {
      developer.log(".....DISPATCHING CHANGE......");
      // ChangeNotification(myID: {tileID})..dispatch(context);
      // tileList[index].toggleMyself();
      keyList[index].currentState.toggleMe();

     // developer.log("about to set the board state.");
   //   setState(() {
         //developer.log("Setting the board state.");
          boardList[index] = !boardList[index];
         // developer.log("boardList:" + boardList.toString());
   // });
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
