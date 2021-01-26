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
  List fullSequence = [];
  List fullSequenceIndexes = [];
  

void generateRandomSequence(sequenceLength) {


    for (var i = 0; i < sequenceLength; i++) {
      var rn = new Random();
      var _randomRow = rn.nextInt(tileCount);
      var _randomCol = rn.nextInt(tileCount);
      var _randomID = {"row": _randomRow, "col": _randomCol};
      var _associatedIndex = _randomRow*tileCount + _randomCol;
      

      // If this index is not already in our list, then we can add it to our list
      // This is because if the tile was touched twice that is the same
      // as not touching it at all -- so we only want to include it in our
      // touched list if it has been hit an "odd" number of times.
      
      if (sequenceIndexes.indexOf(_associatedIndex) == -1) {
        touches.add(_randomID);
        sequenceIndexes.add(_associatedIndex);
      }
    }
    // mySettings.sequence = this;
    // mySettings.sequenceIndexes = sequenceIndexes;
    fullSequence = touches;
    fullSequenceIndexes = sequenceIndexes;

   // developer.log(touches.toString());
  }


// When a tile gets touched, we check to see if it's in the full sequence
// and if not, then we need to add it to the full sequence (weather its on or off)
  int updateSequence( tileID ) {
    var row = tileID["row"];
  
    var col = tileID["col"];
    var tileIndex = row*tileCount + col;

    //developer.log("updating sequence:" + row.toString() + ", " + col.toString());
    // developer.log(touches.toString());
    final found = fullSequenceIndexes.indexWhere((element) =>
        element == tileIndex);
   // developer.log("found: " + found.toString());

    if (found == -1) {
      // then this touch is not in our sequence, so we need to add it to the sequence
      // this is because the user is now making their life harder than it needs to be
      // by selecting a tile that is not in the sequence.

      fullSequence.add(tileID);
      fullSequenceIndexes.add(tileIndex);
      //developer.log("Not found: " + found.toString());
    } 

 

    return found;
  }

// When an adjacent tile is turned off, let's 
  



int findYourOwnDamnObject( needle, haystack ) {

    var row = needle["row"];
    var col = needle["col"];

    for (var i = 0; i < haystack.length; i++) {
      if ((haystack[i]["row"] == row) && (haystack[i]["col"] == col)) {
        return i;
      }
    }

   return -1;
}
bool checkForRemovals(tileID) {
     var row = tileID["row"];
  
    var col = tileID["col"];

  var index = findYourOwnDamnObject(tileID, touches);


  if (index != null && index != -1) {
  touches.removeAt(index);
  } else {
    return false;
  }


  var tileIndex = row*tileCount + col;

  sequenceIndexes.remove(tileIndex);


  var fsIndex = findYourOwnDamnObject(tileID, fullSequence);
  if (fsIndex != null && fsIndex != -1) {
    fullSequence.removeAt(index);
  }


fullSequenceIndexes.remove(tileIndex);
return true;
 


    }
      
}