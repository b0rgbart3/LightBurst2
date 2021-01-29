
import 'package:flutter/material.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';
import '../model/settings.dart';

class GameWon extends StatelessWidget { 
@override
  Widget build(BuildContext context) {
      Settings mySettings = Settings();
      double duration = mySettings.getDuration;
      double score = mySettings.score - (duration*5.0);
      if (score < 0.0) {
        score = 0;
      }
        void newGame() async {
    Navigator.pop(context);
  }

    return Center(
              child:  Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                  border: Border.all(color: mySettings.myColorSet.background ),
                  ),
                  width:mySettings.screenSize*1.1,
                  height: mySettings.screenSize*1.5,
                  
                  
                
        child: Stack( alignment: Alignment.center,
        children: [  BkgImageWidget(),
        Container(
          padding: const EdgeInsets.all(2.0),
          height:mySettings.screenSize,
          alignment: Alignment.center,
          child:
          Column( children: [boxText("NICE JOB!", Colors.white, Colors.black),
          boxText("You completed the puzzle.", Colors.white, Colors.black),
          boxText("Time: " + duration.toStringAsFixed(2) + "s", Colors.white, Colors.black),
          boxText("Your Score: " + score.toStringAsFixed(0), Colors.white, Colors.black),
          
          
          NavButton(
            UniqueKey(), newGame,"PLAY AGAIN", null, 300, 60, false),

          ]
          )
    )])
    )
    );


  
  }

}
