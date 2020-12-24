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
    List boardList = [false,false,false];

  @override
  Widget build(BuildContext context) {
    return Row( mainAxisAlignment: MainAxisAlignment.center, 
   children: [ 
     Box(0, boardList[0], updateBoard), 
     Box(1, boardList[1], updateBoard),
     Box(2, boardList[2], updateBoard), 
     
      ]);
  }

  void updateBoard(boxState, index) {
    boardList[index] = !boardList[index];
   // developer.log(boardState.toString());
    developer.log(boardList.toString());

  }
}
