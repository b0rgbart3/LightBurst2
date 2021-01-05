
import 'package:flutter/material.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';

class GameWon extends StatelessWidget { 
@override
  Widget build(BuildContext context) {
        void newGame() async {
    Navigator.pop(context);
  }

    return Container(
        alignment: Alignment.center,
        color:Colors.black,
        child: Stack( alignment: Alignment.center,
        children: [  BkgImageWidget(), ColorFilterWidget(),
        Container(
          
          height:200,
          alignment: Alignment.center,
          child:
          Column( children: [boxText("NICE JOB!"),
          boxText("You completed the puzzle."),
          
          NavButton(
            UniqueKey(), newGame,"PLAY AGAIN", null, 300, 60, false),
          // RaisedButton(
          //   onPressed: () { newGame(context); },
          //   child: const Text('PLAY AGAIN', style: TextStyle(fontSize: 20)),
          // ),
          ]
          )
    )])
    );


  
  }

}
