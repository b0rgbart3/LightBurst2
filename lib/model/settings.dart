

class Settings {

  int _boardSize;
  int _sequenceLength;
  int initialBoardSize = 5;
  int initialSequenceLength = 4;
  int _minBoardSize = 3;
  int _maxBoardSize = 10;
  int _minSequenceLength = 4;
  int _maxSequenceLength = 10;
  bool _showSequence;
  List _sequence = [];
  List _sequenceOfIndexes = [];

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
  // colorset get color => color;   This is a "getter" for the color value
//  int get boardSize => _boardSize;

  int get minBoardSize => _minBoardSize;
 int get maxBoardSize => _maxBoardSize;

   int get minSequenceLength => _minSequenceLength;
 int get maxSequenceLength => _maxSequenceLength;
 List get sequence => _sequence;
 List get sequenceOfIndexes => _sequenceOfIndexes;

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
 //  int get sequenceLength => _sequenceLength;

  int get sequenceLength {
    if (_sequenceLength == null) {
      _sequenceLength = initialSequenceLength;
    }
    return _sequenceLength;
  }

  set boardSize (int newSize) {
    _boardSize = newSize;
  }

  set sequenceLength( int newSequenceLength) {
    
    if (newSequenceLength < 10 && newSequenceLength > 3) {
      _sequenceLength  = newSequenceLength;
    }
  }

  set showSequence( bool newShowSequence) {
    _showSequence = newShowSequence;
  }

  set sequence( List newSequence ) {
    _sequence = newSequence;
  }

  set sequenceOfIndexes( List newSequenceOfIndexes) {
    _sequenceOfIndexes = newSequenceOfIndexes;
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

  Map <String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["boardSize"] = _boardSize;
    map["sequenceLength"] = _sequenceLength;

    return map;
  }

  // This is the reverse of the map method

  // Another NAMED CONSTRUCTOR

  Settings.fromObject( dynamic o) {
    this._boardSize = o["boardSize"];
    this._sequenceLength = o["sequenceLength"];
  }



}