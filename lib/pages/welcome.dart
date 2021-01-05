import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../components/interface.dart';
import '../pages/gameplay.dart';
import '../components/box.dart';
import '../classes/colorset.dart';
import '../components/tile.dart';
import '../classes/notifications.dart';
import '../model/settings.dart';

class Welcome extends StatelessWidget {

  List tiles=[];
  List keys = [];
  int boardSize;
  int sequenceLength;
  Settings mySettings;

void backInWelcome() {
  
      keys.forEach( (key) => key.currentState.turnOff() );
      developer.log("Back in Welcome: ");

      // mySettings = value;
}
  void aboutToPlay(context) async {
    keys.forEach( (key) => key.currentState.turnOn() );



//  _settingsEditor() async {
//     final result = await Navigator.push(
//             context, MaterialPageRoute(builder: (context) => SettingsEditor()))
//         .then((value) => setState(() {
//               // maybe set some state value here....
//               //  developer.log("RE_SETTING STATE for BOARD");
//              // developer.log("Value back: " + value.toString());
//               boardKey.currentState.setNewValues(value);
//               boardKey.currentState.clearBoard();
//             }));
//    // developer.log("back from settingsEditor");
//   }

    //developer.log('About to play');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Game()))
    .then((value) => backInWelcome()
    

       );
    

            // .then((value) => setState(() {
            //   // maybe set some state value here....
            //   //  developer.log("RE_SETTING STATE for BOARD");
            //  // developer.log("Value back: " + value.toString());
            //   boardKey.currentState.setNewValues(value);
            //   boardKey.currentState.clearBoard();
            // }));

        // .then((value) => setState(() {
        //   // this make is so that when we swipe right to get back to this welcome
        //   // screen, the tile will be in its original condition.
        //       onState = false;
        //     }));


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

    developer.log("Building the welcome tiles");

    if (boardSize == null) {
      boardSize = 5;
    }
    if (sequenceLength == null) {
      sequenceLength = 4;
    }

    buildTiles();
    Widget cross() {

      Colorset introColorSet = Colorset(Colorset.colorssets['blue']);

      return NotificationListener<PlayNotification> (
      onNotification: (notification) {
       //  developer.log('Got notified: ' + notification.id.toString());
       // touchTile(notification.myID);
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
