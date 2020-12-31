// import 'package:box/model/settings.dart';

// We want a singleton -- only one instance of the SettingsHelper

class SettingsHelper {

  int boardSize;
  int sequenceLength;

  // This creates the singleton object
  static final SettingsHelper _settingsHelper = SettingsHelper._internal();


  // Internal Named constructor
  SettingsHelper._internal();


  factory SettingsHelper() {
    // return the singleton object

    return _settingsHelper;
  }

  getSettings() {
    return _settingsHelper;
  }
}