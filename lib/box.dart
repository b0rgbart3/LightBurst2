import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class TouchNotification extends Notification {
  final Object myID;

  const TouchNotification({this.myID});
}
class ChangeNotification extends Notification {
  final Object myID;

  const ChangeNotification({this.myID});
}

class Box extends StatefulWidget  {
  final key, tileSize, rowNum, colNum, initialState;

  //Box({Key key, onState}) : super(key: key);
  Box(this.key, this.tileSize, this.rowNum, this.colNum, this.initialState);

  void toggleMyself() {
    developer.log("toggling myself.");
    // toggleMe();
    
  }

  @override
  BoxState createState() => BoxState();
}

class BoxState extends State<Box>  {
  double endSize;
  bool onState;



  @override
  void initState() {
    super.initState();
    endSize = widget.tileSize * .9;
    onState = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    // var intVersion = myRadius.value.toDouble();
    var myColor;
    // developer.log('onState: ' + widget.onState.toString());
    if (onState) {
      myColor = Colors.blue[400];
    } else {
      myColor = Colors.blue[900];
    }

    return Container(
        alignment: Alignment.center,
        width: widget.tileSize,
        height: widget.tileSize,
        child: GestureDetector(
            onTapDown: pressDown,
            onTapUp: pressUp,
            onTapCancel: pressCancel,
            child: TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: endSize),
                duration: Duration(milliseconds: 100),
                builder: (_, num myWidth, __) {
                  return NotificationListener<ChangeNotification>(
                    onNotification: (notification) {
                      developer.log('Got notified of change: ' + notification.myID.toString());
                      toggleMe();
                      return true;
                    },
                    child:Container(
                    alignment: Alignment.center,
                    width: myWidth,
                    height: myWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: myColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue[600],
                            blurRadius: 5,
                            spreadRadius: 5),
                      ],
                    ),
                  )
                  );
                })
                )
                );
  }

  void pressDown(details) {
    setState(() {
      endSize = widget.tileSize * .75;
    });
  }

  void pressCancel() {
    setState(() {
      endSize = widget.tileSize * .9;
    });
  }

  void pressUp(details) {
    TouchNotification(myID: {'row':widget.rowNum, 'col': widget.colNum })..dispatch(context);
    setState(() {
      // widget.touchTile( { 'row': widget.rowNum, 'col': widget.colNum });
      endSize = widget.tileSize * .9;
    });
  }

  void toggleMe() {
        setState(() {
      onState = !onState;

    });
  }
}
