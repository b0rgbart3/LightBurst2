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
      sequenceOfIndexes.add(_associatedIndex);
    }
    mySettings.sequence = touches;
    mySettings.sequenceOfIndexes = sequenceOfIndexes;
   // developer.log(touches.toString());
  }


}