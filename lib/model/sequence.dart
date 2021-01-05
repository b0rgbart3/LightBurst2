import 'dart:math';
import 'settings.dart';
// import 'dart:developer' as developer;

class Sequence {

  Sequence(this.sequenceLength, this.tileCount);
  final sequenceLength;
  final tileCount;
  Settings mySettings = Settings();
  
  List touches = [];
  List sequenceOfIndexes = [];

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
      
      if (sequenceOfIndexes.indexOf(_associatedIndex) == -1) {
      sequenceOfIndexes.add(_associatedIndex);
      }
    }
    mySettings.sequence = touches;
    mySettings.sequenceOfIndexes = sequenceOfIndexes;
   // developer.log(touches.toString());
  }


}