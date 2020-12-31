

class Settings {

  int _boardSize;
  int _sequenceLength;

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

  int get boardSize => _boardSize;
  int get sequenceLength => _sequenceLength;

  set boardSize (int newSize) {
    _boardSize = newSize;
  }

  set sequenceLength( int newSequenceLength) {
    
    if (newSequenceLength < 10 && newSequenceLength > 3) {
      _sequenceLength  = newSequenceLength;
    }
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