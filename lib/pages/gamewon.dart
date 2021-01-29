
import 'package:flutter/material.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';
import '../model/settings.dart';

class GameWon extends StatelessWidget { 
@override
  Widget build(BuildContext context) {
      Settings mySettings = Settings();

        void newGame() async {
    Navigator.pop(context);
  }

    return Container(
        alignment: Alignment.center,
        color:Colors.black,
        child: Stack( alignment: Alignment.center,
        children: [  BkgImageWidget(),
        Container(
          
          height:500,
          alignment: Alignment.center,
          child:
          Column( children: [boxText("NICE JOB!", Colors.white, Colors.black),
          boxText("You completed the puzzle.", Colors.white, Colors.black),
          boxText("Your Score: " + mySettings.score.toString(), Colors.white, Colors.black),
          boxText("Time: " + mySettings.getDuration.toString(), Colors.white, Colors.black),
          
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
