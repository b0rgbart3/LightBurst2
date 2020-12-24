import 'package:flutter/material.dart';
import 'box.dart';
import 'dart:developer' as developer;

class Board extends StatefulWidget {
  Board({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  int _counter = 0;
  List boardList = [];
   int tileCount = 5;

  void clearBoard() {
    for (var i = 0; i < tileCount*tileCount; i++) {
       boardList.add(false);
    }
  }
  @override
  Widget build(BuildContext context) {
    
    clearBoard();
    return buildRows();
  }

  Widget buildRows() {
    List rows = <Widget> [];

    for (var i = 0; i < tileCount; i++ ) {
      rows.add(buildRow(i));
    }
    return Column( children: rows );
  }
  Widget buildRow(rowNum) {
    double boardSize = MediaQuery.of(context).size.width;
    double tileSize = boardSize / tileCount;
    developer.log("Tile Size: " + tileSize.toString());

    List tiles = <Widget> [];

// Dynamically build a whole row of tiles
    for (var i = 0; i < tileCount; i++) {
      tiles.add(Box(tileSize, rowNum, i, boardList[i], updateBoard));
    }
    return Row( mainAxisAlignment: MainAxisAlignment.center, 
   children: tiles

      );
  }

  void updateBoard(boxState, rowNum, colNum) {
    var index = rowNum * tileCount + colNum;
    boardList[index] = !boardList[index];
    developer.log("");
    developer.log(boardList.toString());

  }
}
