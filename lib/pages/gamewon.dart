
import 'package:flutter/material.dart';
import '../components/interface.dart';

class GameWon extends StatelessWidget { 
@override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color:Colors.black,
        child: Stack( alignment: Alignment.center,
        children: [  BkgImageWidget(), ColorFilterWidget(),
        Container(
          
          height:200,
          alignment: Alignment.center,
          child:
          Column( children: [boxText("NICE JOB!"),
          boxText("You completed the puzzle."),
          
          RaisedButton(
            onPressed: () { newGame(context); },
            child: const Text('PLAY AGAIN', style: TextStyle(fontSize: 20)),
          ),
          ]
          )
    )])
    );




  }
    void newGame(BuildContext context) async {
    Navigator.pop(context);
  }
  
}
