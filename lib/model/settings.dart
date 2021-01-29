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
  int _maxBoardSize = 10;
  int _minSequenceLength = 3;
  int _maxSequenceLength = 10;
  double _screenSize;
  double _screenWidth;
  double _screenHeight;
  bool _showSequence;
  Sequence _sequence;
  Colorset _myColorSet;
  int _colorIndex = 0;
  int _minColorIndex = 0;
  int _maxColorIndex =2;
  BuildContext _context;
  double _tileSize;

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
  int get colorIndex => _colorIndex;
  int get minColorIndex => _minColorIndex;

  int get minSequenceLength => _minSequenceLength;
  int get maxSequenceLength => _maxSequenceLength;

  int get maxColorIndex{
    if (_maxColorIndex == null) {
      _maxColorIndex = 2;
    }
    return _maxColorIndex;
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

  double get tileSize {
    if (_tileSize == null) {
      _tileSize = screenSize / _boardSize;
    }
    return _tileSize;
  }

  void freshBoardList() {
   // _boardList = [];
    sequence.fresh();
    _tileSize = null;

    // for (var i = 0; i < (_boardSize * _boardSize); i++) {
    //   // developer.log("_boardList: " + _boardList.toString());
    //   _boardList.add(false);
    // }
    _sequence = new Sequence(_sequenceLength, _boardSize);
    //_sequence.generateRandomSequence(sequenceLength);
    // developer.log("_boardList: " + _boardList.toString());
  }

  void toggleTile( tileIndex) {
    //_boardList[index] = !_boardList[index];
    //int index = (tileID["row"] * _boardSize ) + tileID["col"];
    double rowDouble = tileIndex/_boardSize;
    int row = rowDouble.floor();
    var tileID= {"row":row ,"col":tileIndex%_boardSize};
    sequence.touchBoard(tileID, tileIndex, false);
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
    return _boardCreated;
  }


  //  int get sequenceLength => _sequenceLength;

  int get sequenceLength {
    if (_sequenceLength == null) {
      _sequenceLength = initialSequenceLength;
    }
    return _sequenceLength;
  }

  Colorset get myColorSet {
    if (_myColorSet == null) {
      _myColorSet = new Colorset(_colorIndex);
    }
    return _myColorSet;
  }

  double get screenSize {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    _screenSize = _screenHeight / 2;
    if (_screenSize > _screenWidth) {
      _screenSize = _screenWidth *.9;
    }

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
