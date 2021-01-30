import 'package:flutter/material.dart';
import 'box.dart';
import '../model/sequence.dart';
import 'dart:developer' as developer;
import '../pages/gamewon.dart';
import '../classes/notifications.dart';
import '../model/settings.dart';
import '../components/interface.dart';
import '../components/tile.dart';

class Demo extends StatefulWidget {
  Demo({Key key}) : super(key: key);

  @override
  State createState() => DemoState();
}

class DemoState extends State<Demo> {

  int myIntValue;
  double ballWidth = 50.0;
  double range;
  bool tracking = false;
  double myX;
  double origin;
  bool tile1,tile2,tile3,tile4,tile5 = false;
  Stopwatch _demostopwatch;

  List tiles=[];
  List keys = [];

@override
void initState() {
  super.initState(); 
}

void startTimer() {

   developer.log("Start the demo.");
   _demostopwatch = new Stopwatch();
   _demostopwatch.start();


}
    void buildTiles() {
    Key key0 = GlobalKey();
    tiles.add( Tile( key0, 70.0, 0, "", false ) );
    Key key1 = GlobalKey();
     tiles.add( Tile( key1, 70.0, 1, "", false ) );
    Key key2 = GlobalKey();
     tiles.add( Tile( key2, 70.0, 2, "", true ) );
    Key key3 = GlobalKey();
     tiles.add( Tile( key3, 70.0, 3, "", false ) );
    Key key4 = GlobalKey();
    tiles.add( Tile( key4, 70.0, 4, "", false ) );

    keys.add(key0);
    keys.add(key1);
    keys.add(key2);
    keys.add(key3);
    keys.add(key4);
  }

  Widget cross() {
    buildTiles();
    startTimer();
      return  Padding(
        padding: EdgeInsets.only(bottom: 14.0),
        child: Column(children: [
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
      )])
       )
       ;
    }

  @override
  Widget build(BuildContext context) {
      Settings mySettings = Settings();

      
  

    return cross();
  }

}
