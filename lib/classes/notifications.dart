

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PlayNotification extends Notification {
  final Object id;

  const PlayNotification({this.id});
}


class DragNotification extends Notification {
  final Object id;
  int value;

  // Need to Add Settings Value to this notification object

  DragNotification({this.id, this.value});
}

