import 'dart:math';
import 'settings.dart';
import 'dart:developer' as developer;

class Sequence {

  Sequence(this.sequenceLength, this.tileCount);
  final sequenceLength;
  final tileCount;
  Settings mySettings = Settings();
  
  List touches = [];
  List sequenceIndexes = [];

void generateRandomSequence(sequenceLength) {

    //developer.log("TileCount: " + tileCount.toString());

    for (var i = 0; i < sequenceLength; i++) {
      var rn = new Random();
      var _randomRow = rn.nextInt(tileCount);
      var _randomCol = rn.nextInt(tileCount);
      var _randomID = {"row": _randomRow, "col": _randomCol};
      var _associatedIndex = _randomRow*tileCount + _randomCol;
      touches.add(_randomID);

      // If this index is not already in our list, then we can add it to our list
      // This is because if the tile was touched twice that is the same
      // as not touching it at all -- so we only want to include it in our
      // touched list if it has been hit an "odd" number of times.
      
      if (sequenceIndexes.indexOf(_associatedIndex) == -1) {
      sequenceIndexes.add(_associatedIndex);
      }
    }
    mySettings.sequence = this;
    mySettings.sequenceIndexes = sequenceIndexes;
   // developer.log(touches.toString());
  }

  void updateSequence( tileID ) {
 

    var row = tileID["row"];
    var col = tileID["col"];

    developer.log("updating sequence:" + row.toString() + ", " + col.toString());
    developer.log(touches.toString());
    final found = touches.indexWhere((element) =>
        element["row"] == row && element["col"] == col);
    if (found == -1) {
      // then this touch is not in our sequence, so we need to add it to the sequence
      // this is because the user is now making their life harder than it needs to be
      // by selecting a tile that is not in the sequence.

      touches.add(tileID);
      mySettings.addTosequenceIndexes(tileID);
    } 
  }


}