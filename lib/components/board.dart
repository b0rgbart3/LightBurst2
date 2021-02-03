import 'package:flutter/material.dart';
import 'box.dart';
import '../model/sequence.dart';
import 'dart:developer' as developer;
import '../model/settings.dart';
import '../classes/notifications.dart';
import '../classes/tileID.dart';

class Board extends StatefulWidget {
  Board({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {

  List tileList;
  List keyList;
  Settings mySettings = Settings();
  int sequenceLength;

@override
void initState() {
    super.initState();

    if (tileList == null) {
      tileList = [];
    }
    if (keyList == null) {
      keyList = [];
    }

    if (sequenceLength == null) {
      sequenceLength = mySettings.sequenceLength;
    }
}
  


  void clearBoard( ) {
    tileList = [];
    keyList = [];

    sequenceLength = mySettings.sequenceLength;
     
  }
  
  // This is the main method that gets invoked when a box is touched.
  // So we need to toggle the tile, and it's neighbors, and update
  // the sequence -- because if this tile is not in the sequence,
  // then we need to add it to the sequence (the user just made it harder on 
  // themselves )

  void touchTile( tileIndex ) {
      mySettings.toggleTile( tileIndex);

      setState(() { });
  }


bool getCurrentState( tileID ) {
  var index = tileID['row'] * mySettings.boardSize + tileID['col'];
  return  mySettings.sequence.board[index];
}
// Returns true if the values are "new".
// If the values are the same as before, we return false

  bool setNewValues() {
    // Note: I used to pass the values in as an object coming from the
    // Notifier.
    var settingsChanged = false;


    if (sequenceLength != mySettings.sequenceLength) {
      sequenceLength = mySettings.sequenceLength;
      settingsChanged = true;
    }
    return settingsChanged;
  }

  @override
  Widget build(BuildContext context) {

    return NotificationListener<TouchNotification> (
      onNotification: (notification) {
        touchTile(notification.myID);
        
      },
      child:buildRows() );
  }

  Widget buildRows() {
    List rows = <Widget>[];
    for (var i = 0; i < mySettings.boardSize; i++) {
      rows.add(buildRow(i));
    }
    return Column(children: rows);
  }

  Widget buildRow(rowNum) {
    
    List tiles = <Widget>[];

// Dynamically build a whole row of tiles
    for (var i = 0; i < mySettings.boardSize; i++) {
     var index = rowNum*mySettings.boardSize + i;
      var box = Box(index: index);
      tiles.add(box);
      tileList.add(box);
  }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: tiles);
  }
}