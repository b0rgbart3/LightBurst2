import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Box extends StatefulWidget {
   var index;
   var onState;
   var updateBoard;

   //Box({Key key, onState}) : super(key: key);
   Box(this.index, this.onState, this.updateBoard);

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {

  var endSize = 90.0;
  
  @override
  Widget build(BuildContext context) {

    // var intVersion = myRadius.value.toDouble();
  var myColor;
  // developer.log('onState: ' + widget.onState.toString());
  if (widget.onState) {
    myColor = Colors.orange;
  } else {
    myColor = Colors.red;
  }


    return 
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
      );
  }

void pressDown(details) {
    setState(() {
       endSize = 50.0; 
       
  });
}

void pressCancel() {
      setState(() {
       endSize = 90.0; 
       
  });
}

  void pressUp(details) {
  
  
  setState(() {
       widget.onState = !widget.onState;
       widget.updateBoard(widget.onState, widget.index);
       endSize = 90.0;
       
  });

  }


}