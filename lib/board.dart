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
  int tileCount = 5;
  int sequenceLength = 10;
  Sequence _sequence;

  void clearBoard() {
    for (var i = 0; i < tileCount * tileCount; i++) {
      boardList.add(false);
    }
  }
  void touchTile( tileID ) {
   // developer.log(tileID.toString());
    var index = tileID['row'] * tileCount + tileID['col'];
    // developer.log('Index: ' + index.toString());
    toggleTile(index);

    //above
    var above = tileID['row'] -1;
    if (above >= 0) { 
      toggleTile(  above * tileCount + tileID['col'] );
     }
    //below
    var below = tileID['row'] +1;
    if (below < tileCount) { 
      toggleTile(  below * tileCount + tileID['col'] );
    }

    //left
    var left = tileID['col'] -1;
    if (left >= 0) { 
      toggleTile( tileID['row'] * tileCount + left );
    }
    //right
    var right = tileID['col'] + 1;
    if (right < tileCount) { 
      toggleTile( tileID['row']*tileCount + right );
    }
  }

  void toggleTile( index) {
    boardList[index] = !boardList[index];
    developer.log('Toggling: ' + index.toString());
    developer.log(boardList.toString());
  }

  @override
  Widget build(BuildContext context) {
    clearBoard();
    _sequence = new Sequence(sequenceLength, tileCount);
    _sequence.generateRandomSequence(sequenceLength);
    developer.log(boardList.toString());
    _sequence.touches.forEach((ID) => 
       touchTile(ID)
    );

    // developer.log(boardList.toString());
    return buildRows();
  }

  Widget buildRows() {
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
      tiles.add(Box(tileSize, rowNum, i, boardList[rowNum * tileCount + i], updateBoard));
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: tiles);
  }

  void updateBoard(boxState, rowNum, colNum) {
    var index = rowNum * tileCount + colNum;
    boardList[index] = !boardList[index];

  }
}
