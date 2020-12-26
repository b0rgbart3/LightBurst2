import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Box extends StatefulWidget {
  final tileSize, rowNum, colNum, touchTile, initialState;

  //Box({Key key, onState}) : super(key: key);
  Box(this.tileSize, this.rowNum, this.colNum, this.initialState,
      this.touchTile);

  void toggleMyself() {
    developer.log("toggling myself.");

  }

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
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
                  return Container(
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
                  );
                })));
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
    setState(() {
      widget.touchTile( { 'row': widget.rowNum, 'col': widget.colNum });
      endSize = widget.tileSize * .9;
    });
  }

  void toggleMe() {
        setState(() {
      onState = !onState;

    });
  }
}
