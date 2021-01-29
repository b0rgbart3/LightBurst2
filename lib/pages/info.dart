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

class Info extends StatelessWidget {
  Settings mySettings = Settings();

  @override
  Widget build(BuildContext context) {

      
      return  Scaffold( 
        body: Stack( children: [
          BkgImageWidget(),
          ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children:[Center(
              child:  Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                  border: Border.all(color: mySettings.myColorSet.background ),
                  ),
                  width:mySettings.screenSize*1.1,
                  
                  child:Padding(
        padding: EdgeInsets.symmetric(vertical: 70.0),
        child: Column(children: [
      Column(
        children: [
         TitleText("LIGHTBURST"),
         infoText("Welcome to LightBurst. The object of the game is to turn off all of the lights. When you click on a tile, it toggles it's own state, and the state of the tiles in it's immediate surrounding.  See if you can figure out the pattern and turn off all of the lights to win the game.  Your score is based on how many correct guesses you make, how many incorrect guesses, and the time it takes you to complete the puzzle.", Colors.white, Colors.black),
        infoText("You can make the game easier or harder by changing the number of tiles on the board, and the length of the randomized sequence.  Note the longer the sequence is, the more difficult the challenge is, but you will also gain a higher score as a result.", Colors.white, Colors.black),
                infoText("You can get help by clicking on the reveal icon.  This will show you which tiles need to be touched to clear the board.  Note, this advantage disappears after 3 seconds, and using it will significantly reduce your overall score.", Colors.white, Colors.black),
         NavButton(
                              null,
                              ()=>Navigator.pop(context ),
                              "",
                              Icon(Icons.done,
                                  size: 54.0, color: mySettings.myColorSet.text),
                              65.0,
                              65.0, false),
        ],
      )])
      )
       )
       
      )]
      )]
      ));

    
}
}

