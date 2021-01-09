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

    //developer.log("TileCount: " + tileCount.toString());

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
    developer.log("found: " + found.toString());

    if (found == -1) {
      // then this touch is not in our sequence, so we need to add it to the sequence
      // this is because the user is now making their life harder than it needs to be
      // by selecting a tile that is not in the sequence.

      fullSequence.add(tileID);
      fullSequenceIndexes.add(tileIndex);
      //developer.log("Not found: " + found.toString());
    } 
    else {
   
      //touches.remove(tileID); 
      // if (sequenceIndexes[tileIndex]) {
      // sequenceIndexes.remove(tileIndex);
      // }
     
      // fullSequence.removeAt(found);
      // if (fullSequenceIndexes[tileIndex]) {
      // fullSequenceIndexes.remove(tileIndex);
      // }
    }
      // developer.log("Else found: " + found.toString());
      // remove it from the fullSequence
     // fullSequenceIndexes.removeAt(found);
     // var objectIndex = fullSequence.indexWhere((element) => element == tileID);
      //fullSequence.removeAt(objectIndex);
      
      //developer.log("board list: " + boardList.toString());

    return found;
  }

// When an adjacent tile is turned off, let's 
  




void checkForRemovals(tileID) {

developer.log("In Check for Removals.");
    //  fullSequence.forEach(( tileID ) {
    //     developer.log("About to check: " + tileID.toString());
    //  });

developer.log("---about to check: " + tileID.toString());
  //  final found = touches.indexWhere((element) =>
  //       element == tileID);
  
  // Here I need to check to see if the tile that just got touched
  // is in the original sequence.... but somehow I need to only
  // do this on User touches -- not the computer generated touches
  // that happen when building the board -- so I guess I need to
  // check if the board is done building, and only run this
  // method in that case.
  touches.remove(tileID);
   var tileIndex = tileID["row"]*tileCount + tileID["col"];
  sequenceIndexes.remove(tileIndex);
  fullSequence.remove(tileID);
  fullSequenceIndexes.remove(tileIndex);

      // if (boardList[tileIndex] == false) {
      //   developer.log("checking this tile: " + tileID.toString());
      //   // above
      //   if (row > 0) {
      //     var aboveIndex = ((row-1)*tileCount) + col;
      //     developer.log('above:' + aboveIndex.toString());
      //     developer.log(boardList.toString());
        
      //     if (aboveIndex > 0 && boardList[aboveIndex] == false)
      //     {
      //         developer.log('boardList of above:' + boardList[aboveIndex].toString());
      //       aboveOff = true;
      //     }
      //     if (aboveIndex < 0 ) {
      //       aboveOff = true;
      //     }
      //     developer.log('above off:' + aboveOff.toString());
      //   }
      //   // below
      //   if (row < tileCount) {
      //     var belowIndex = ((row+1)*tileCount) + col;
      //     developer.log('below:' + belowIndex.toString());
         
      //     if (belowIndex < (tileCount*tileCount) && boardList[belowIndex] == false) {
      //          developer.log('boardList of below:' + boardList[belowIndex].toString());
      //       belowOff = true;
      //     }
      //     if (belowIndex > (tileCount*tileCount))
      //     {
      //       belowOff = true;
      //     }
      //      developer.log('below off:' + belowOff.toString());
      //   }
      //   // left
      //   if (col > 0) {
      //     var leftIndex = (row*tileCount) + (col-1);
      //      developer.log('left:' + leftIndex.toString());
      //     if (leftIndex >= 0 && boardList[leftIndex] == false) {
      //       leftOff = true;
      //     }
      //     if ((col-1) < 0) {
      //       leftOff = true;
      //     }
      //   }
      //   // right
      //     if (col < tileCount) {
      //     var rightIndex = (row*tileCount) + (col+1);
      //     developer.log('right:' + rightIndex.toString());
      //     if (rightIndex < (tileCount*tileCount) && boardList[rightIndex] == false) {
      //       rightOff = true;
      //     }
      //     if ((col+1) > tileCount) {
      //       rightOff = true;
      //     }
      //   }
      //   if (aboveOff && belowOff && leftOff && rightOff) {
      //     markForRemoval = true;
      //   }
      

      // if (markForRemoval) {
      //   developer.log("safe to remove: " + tileID.toString());
      // }
      // }
    }
      
}