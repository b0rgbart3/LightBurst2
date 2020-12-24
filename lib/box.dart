import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Box extends StatefulWidget {
   final tileSize;
   final rowNum;
   final colNum;
   final updateBoard;
   final initialState;
  
   //Box({Key key, onState}) : super(key: key);
   Box(this.tileSize, this.rowNum, this.colNum, this.initialState, this.updateBoard);

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {

  double endSize;
  bool onState;
  
  @override
  void initState() {
    endSize = widget.tileSize*.9;
    onState = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
  
    // var intVersion = myRadius.value.toDouble();
  var myColor;
  // developer.log('onState: ' + widget.onState.toString());
  if (onState) {
    myColor = Colors.orange;
  } else {
    myColor = Colors.red;
  }


    return Container(alignment: Alignment.center,
    width: widget.tileSize, height: widget.tileSize,
    child:
      GestureDetector(
      
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
        color:myColor,
        boxShadow: [
          BoxShadow(
              color: Colors.orange[100], blurRadius: 5, spreadRadius: 5),
        ],
      ),
    ); 
    }
    )
      )
      );
  }

void pressDown(details) {
    setState(() {
       endSize = widget.tileSize*.75;
       
  });
}

void pressCancel() {
      setState(() {
       endSize = widget.tileSize*.9;
       
  });
}

  void pressUp(details) {
  
  
  setState(() {
       onState = !onState;
       widget.updateBoard(onState, widget.rowNum, widget.colNum);
       endSize = widget.tileSize*.9;
       
  });

  }


}