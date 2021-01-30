import 'dart:developer' as developer;
import 'dart:math';
import '../model/sequence.dart';
import '../classes/colorset.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../classes/notifications.dart';
// This Settings class creates a "singleton" which
// I am using as our Global State Object

class Settings  {
  int _boardSize;
  bool _boardCreated;
  int _sequenceLength;
  int initialBoardSize = 5;
  int initialSequenceLength = 4;
  int _minBoardSize = 3;
  int _maxBoardSize = 9;
  int _minSequenceLength = 3;
  int _maxSequenceLength = 14;
  double _screenSize;
  double _screenWidth;
  double _screenHeight;
  bool _showSequence;
  Sequence _sequence;
  Colorset _myColorSet;
  int _colorIndex;
  int _minColorIndex = 0;
  int _maxColorIndex;
  BuildContext _context;
  double _tileSize;
  double _score;
  double _point;
  double _initialScore;
  Stopwatch _s;
  

  // List _sequenceIndexes = [];

  //Settings( this._boardSize, this._sequenceLength);

  // Singleton settings object
  static final Settings _settings = Settings._internal();

  // Internal Named constructor
  Settings._internal();

  factory Settings() {
    // return the singleton object
    return _settings;
  }
  // Named Constructor could look like this:
  // Options.withColor( this.color, this.boardSize, this.sequenceLength)
  // colorset get color => color;
  //This is a "getter" for the color value
//  int get boardSize => _boardSize;

  int get minBoardSize => _minBoardSize;
  int get maxBoardSize => _maxBoardSize;
  int get colorIndex {
    if (_colorIndex == null) {
     
      var rn = new Random();
      int numberOfColors = Colorset.colorsets.length - 1;
      developer.log("number of colors: "+ numberOfColors.toString());
      var _randomColor= rn.nextInt(numberOfColors);
      _colorIndex = _randomColor;
       developer.log("generating new colorIndex: " + _colorIndex.toString());
    }
    return _colorIndex;

  } 
  int get minColorIndex => _minColorIndex;

  int get minSequenceLength => _minSequenceLength;
  int get maxSequenceLength => _maxSequenceLength;

  int get maxColorIndex{
    if (_maxColorIndex == null) {
      _maxColorIndex = Colorset.colorsets.length -1;
    }
    return _maxColorIndex;
  }

double get initialScore {
  if (_initialScore == null) {
    _initialScore = 100.0 * sequenceLength;

  }
  return _initialScore;
}
  double get score {
    if (_score == null) {
      _score = initialScore;
    }
    return _score;
  }

  Sequence get sequence {
    if (_sequence == null) {
      _sequence = new Sequence(_sequenceLength, _boardSize);
    }
    return _sequence;
  }
  //List get sequenceIndexes => _sequenceIndexes;

  BuildContext get context {
    return _context;
  }

  void decreaseScore(demerit) {
    _score = _score-demerit;
  }

  double get tileSize {
    if (_tileSize == null) {
      _tileSize = screenSize / _boardSize;
    }
    return _tileSize;
  }

  void freshBoardList() {
    sequence.fresh();
    _tileSize = null;
    _score = null;
    _sequence = new Sequence(_sequenceLength, _boardSize);
     _s = new Stopwatch();
     _s.start();
     _initialScore = null;
  }

  void toggleTile( tileIndex) {
    //_boardList[index] = !_boardList[index];
    //int index = (tileID["row"] * _boardSize ) + tileID["col"];
    double rowDouble = tileIndex/_boardSize;
    int row = rowDouble.floor();
    var tileID= {"row":row ,"col":tileIndex%_boardSize};
    bool goodChoice = sequence.touchBoard(tileID, tileIndex, false);
    if (goodChoice) {
      _score = _score + _point;
    } else {
      _score = _score -(_point*2);
    }
    //developer.log("toggleing tile: " + index.toString());
  }

  bool get showSequence {
    if (_showSequence == null) {
      _showSequence = false;
    }
    return _showSequence;
  }

  int get boardSize {
    if (_boardSize == null) {
      _boardSize = initialBoardSize;
    }
    return _boardSize;
  }

  bool get boardCreated {
    if (_boardCreated == null) {
      _boardCreated = false;
    }
     _s = new Stopwatch();
     _s.start();
    return _boardCreated;
  }


  //  int get sequenceLength => _sequenceLength;

  int get sequenceLength {
    if (_sequenceLength == null) {
      _sequenceLength = initialSequenceLength;
    }
    _point = _sequenceLength * 20.0;
    return _sequenceLength;
  }

  Colorset get myColorSet {
    if (_myColorSet == null) {
      _myColorSet = new Colorset(colorIndex);
    }
    _myColorSet = Colorset(colorIndex);
    return _myColorSet;
  }

  double get screenSize {
     _screenWidth = MediaQuery.of(context).size.width;
     _screenHeight = MediaQuery.of(context).size.height;

    _screenSize = _screenHeight *.5;

    return _screenSize;
  }

  set context( newContext ) {
    _context = newContext;
  }

  set colorIndex(newIndex) {
    _colorIndex = newIndex;
    _myColorSet = Colorset(_colorIndex);
  }

  set myColorSet(newSet) {
    _myColorSet = Colorset(newSet);
  }

  set boardSize(int newSize) {
    _boardSize = newSize;
    _sequence = null;
  }


  set sequenceLength(int newSequenceLength) {
    if (newSequenceLength <=maxSequenceLength && newSequenceLength >= minSequenceLength) {
      _sequenceLength = newSequenceLength;
    }
    _sequence = null;
  }

  set showSequence(bool newShowSequence) {
    _showSequence = newShowSequence;
  }

  set sequence(Sequence newSequence) {
    _sequence = newSequence;
    _boardCreated = true;
  }


  set boardCreated(bool newBoardCreated) {
  
    _boardCreated = newBoardCreated;
  }



  void toggleShowSequence() {
    if (_showSequence == null) {
      _showSequence = false;
    }
    _showSequence = !_showSequence;

  

  }

  double get getDuration {
    double duration = 0;
    if (_s != null) {
    _s.stop();
    duration = _s.elapsedMilliseconds / 1000.0;
    }
    return duration;

  }
// A Collection of key value pairs
// Maps can be iterated
// String is the key
// Dynamic data type as the value
// This method will transform our Options Class into a Map so that
// we can manipulate it and transform it
// This is more useful when using SQLite (database storage)

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["boardSize"] = _boardSize;
    map["sequenceLength"] = _sequenceLength;

    return map;
  }

  // This is the reverse of the map method

  // Another NAMED CONSTRUCTOR

  Settings.fromObject(dynamic o) {
    this._boardSize = o["boardSize"];
    this._sequenceLength = o["sequenceLength"];
  }
}
