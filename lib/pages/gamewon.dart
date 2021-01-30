
import 'package:flutter/material.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';
import '../model/settings.dart';
import '../components/framer.dart';

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

    return Framer(
          Column( children: [boxText("YOU WON!", Colors.white, Colors.black),
          boxText("You finished in: " + duration.toStringAsFixed(0) + " seconds.", Colors.white, Colors.black),
         
          boxText("Your Score: " + score.toStringAsFixed(0), Colors.white, Colors.black),
          boxText(" ", Colors.white, Colors.black),
          
          NavButton(
            UniqueKey(), newGame,"PLAY AGAIN", null, 300, 60, false),

          ]
          )
    );
  }

}
