import 'package:flutter/material.dart';
// import 'dart:developer' as developer;
import '../components/interface.dart';
import '../pages/gameplay.dart';

class Welcome extends StatelessWidget { 
   
   @override
  Widget build(BuildContext context) {

    void gamePlay() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GamePlay()));
  }
  

    return Container(
        alignment: Alignment.center,
        color:Colors.black,
        child: Stack( alignment: Alignment.center,
        children: [  
          BkgImageWidget(), ColorFilterWidget(),
        Container(
          height:200,
          alignment: Alignment.center,
          child:
          Column( children: [titleText(),
          
          RaisedButton(
            onPressed: () { 
            
               gamePlay();
             },
            child: const Text('PLAY', style: TextStyle(fontSize: 20)),
          ),
          ]
          )
    )])
    );


  }
}

