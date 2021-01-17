import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../components/interface.dart';
import '../pages/gameplay.dart';
import '../components/box.dart';
import '../classes/colorset.dart';
import '../components/tile.dart';
import '../classes/notifications.dart';
import '../model/settings.dart';

// This is our welcome / home page
// it displays the cross hairs of tiles with the play
// button in the middle.  This acts sort of like a splash
// logo intro screen.  Note: the game doesn't start until
// the user clicks "play" -- this is a psychological device
// to put the user in the mindset to enjoy the game.

// Note: this welcome screen uses "tiles" instead of boxes
// which means there is some duplication between the Box
// component and the 'tile' component -- but for now I still
// have both because I wanted to display the word "play" in
// the middle of the middle tile and have it scale appropriately
// but for most of the rest of the game there is no text
// so the rest of the game uses the 'box' component.  

// I would like to refactor this welcome screen to also use
// the box component instead of the tile component, but for
// now this is the way it is coded.

class Welcome extends StatelessWidget {

  List tiles=[];
  List keys = [];
  int boardSize;
  int sequenceLength;
  Settings mySettings;

void backInWelcome() {
      keys.forEach( (key) => key.currentState.turnOff() );
}
  void aboutToPlay(context) async {
    keys.forEach( (key) => key.currentState.turnOn() );

    Navigator.push(context, MaterialPageRoute(builder: (context) => Game()))
    .then((value) => backInWelcome()
       );

  }

  void buildTiles() {
    Key key0 = GlobalKey();
    tiles.add( Tile( key0, 0, "", false ) );
    Key key1 = GlobalKey();
     tiles.add( Tile( key1, 1, "", false ) );
    Key key2 = GlobalKey();
     tiles.add( Tile( key2, 2, "Play", true ) );
    Key key3 = GlobalKey();
     tiles.add( Tile( key3, 3, "", false ) );
    Key key4 = GlobalKey();
    tiles.add( Tile( key4, 4, "", false ) );

    keys.add(key0);
    keys.add(key1);
    keys.add(key2);
    keys.add(key3);
    keys.add(key4);
  }
  
  @override
  Widget build(BuildContext context) {

    if (boardSize == null) {
      boardSize = 5;
    }
    if (sequenceLength == null) {
      sequenceLength = 4;
    }

    buildTiles();
    Widget cross() {

      
      return NotificationListener<PlayNotification> (
      onNotification: (notification) {
         aboutToPlay(context);
        return true;
      },
      child:
      Column(
        children: [
         
          tiles[0],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                 tiles[1],
                 tiles[2],
                tiles[3],
            ],
          ),
             tiles[4],
        ],
      )
       );
    }

    return Column (
      
        children: [Stack(alignment: Alignment.center, children: [
          BkgImageWidget(),
          ColorFilterWidget(),
          Container(
              alignment: Alignment.center,
              child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100.0),
        child: Column(children: [TitleText("LIGHTBURST"), cross()])
        )
          )
        ]
        )]
        );
  }
}
