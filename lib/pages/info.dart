import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../components/interface.dart';
import '../components/interface.dart';
import 'gameplay.dart';
import '../components/box.dart';
import '../classes/colorset.dart';
import '../components/tile.dart';
import '../classes/notifications.dart';
import '../components/navbutton.dart';
import '../model/settings.dart';
import '../components/framer.dart';

class Info extends StatelessWidget {
  Settings mySettings = Settings();

Widget settingsInfo() {
  return infoWidget("Make the game easier or harder by changing the number of tiles on the board, and the length of the randomized sequence.  The longer the sequence is, the more difficult the challenge will be-- but you will also gain a higher score as a result.", Icons.settings);
}

Widget infoWidget( textString, icon ) {
  return Container(
    child:Padding(padding: const EdgeInsets.only(bottom:10.0, top:10.0), child:Row(
      crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            NavButton( null,null,"",Icon(icon,
              color: mySettings.myColorSet.text,
              size: 40.0), 65.0, 65.0, false, false), 
              Container(
                width:mySettings.screenSize*.8,
                child:
              infoText(textString, Colors.white, Colors.black)
              )
              ]
      )
  ))
  ;
}

Widget newGameInfo() {
  return infoWidget("Click the plus icon to start a whole new game with a fresh new random sequence.", Icons.add);
}

Widget revealInfo() {
  return infoWidget("You can get help by clicking on the reveal icon.  This will show you which tiles need to be touched to clear the board.  This advantage disappears after 3 seconds and using it will significantly reduce your final score.", Icons.visibility);
}
  @override
  Widget build(BuildContext context) {

      
      return  Framer(
          ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom:15.0),
              children:[Center(
              child:  Container(
                  margin: const EdgeInsets.only(bottom:40.0),
                  padding: const EdgeInsets.only(bottom:50.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
               
                  ),
                  width:mySettings.screenSize*1.1,
                  
                  child:Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: Column(children: [
      Column(
        children: [
         TitleText("LIGHTBURST"),
         infoText("Welcome to LightBurst! The object of the game is to turn off all of the lights. When you click on a tile, it toggles it's own state, and the state of the tiles in it's immediate surrounding.  See if you can figure out the pattern and turn off all of the lights to win the game.  Your score is based on how many correct guesses you make, how many incorrect guesses, and the time it takes you to complete the puzzle.", Colors.white, Colors.black),
        settingsInfo(),
        revealInfo(),
        newGameInfo(),
                infoText("Have fun!", Colors.white, Colors.black),
         NavButton(
                              null,
                              ()=>Navigator.pop(context ),
                              "",
                              Icon(Icons.done,
                                  size: 54.0, color: mySettings.myColorSet.text),
                              65.0,
                              65.0, false, false),
        ],
      )])
      )
       )
       
      )]
      )
      );

    
}
}

