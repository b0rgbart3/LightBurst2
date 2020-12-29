
import 'package:flutter/material.dart';

class GameWon extends StatelessWidget { 
@override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color:Colors.black,
        child: Container(
          color:Colors.blue,
          height:200,
          alignment: Alignment.center,
          child:
          Column( children: [boxText("NICE JOB!"),
          boxText("You completed the puzzle."),
          
          RaisedButton(
            onPressed: () { newGame(context); },
            child: const Text('PLAY AGAIN', style: TextStyle(fontSize: 20)),
          ),
          ]
          )
    )
    );




  }
    void newGame(BuildContext context) async {
    Navigator.pop(context);
  }
  
}

Widget boxText(myString) {
    return Text(myString,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          fontFamily: 'Heebo',
          fontSize: 30,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(0, 0),
              blurRadius: 15,
            ),
          ],
        ));
  }
