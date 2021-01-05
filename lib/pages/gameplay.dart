import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../components/board.dart';
import '../components/interface.dart';
import 'settingseditor.dart';
import '../components/navbutton.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/settings.dart';


// class GamePlay extends StatelessWidget {
//   // This widget is the root of the application.
//   Settings mySettings = Settings();
//   GamePlay();

//   @override
//   Widget build(BuildContext context) {
//     var sensitivity = 8;

//   mySettings = Settings();

//   Key gameKey = UniqueKey();
//   //  GlobalKey<BoardState> boardKey = GlobalKey();

//   void returnToWelcome() {
//       Navigator.pop(context);
//     }

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'LightBurst',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: GestureDetector(
//           onHorizontalDragUpdate: (details) {
//             // Note: Sensitivity is integer used when you don't want to mess up vertical drag
//             // developer.log(details.delta.dx.toString());
//             if (details.delta.dx > sensitivity) {
//               // Right Swipe
//               // developer.log("swipe right");
//               returnToWelcome();
//             } else if (details.delta.dx < -sensitivity) {
//               //Left Swipe
//               // developer.log("swipe left");
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => SettingsEditor())).then((value) =>
         
//                   // setState(() {
//                   //   // this make is so that when we swipe right to get back to this welcome
//                   //   // screen, the tile will be in its original condition.
//                   //       onState = false;
//                   //     })
//                       )
//             }
//           },
//           child: Game(key: gameKey, title: 'LightBurst', returnToWelcome: returnToWelcome )),
//     );
//   }
// }

class Game extends StatefulWidget {
  Game({Key key, this.title, this.returnToWelcome}) : super(key: key);
  final String title;
  final returnToWelcome;
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _counter = 0;
 GlobalKey<NavButtonState> revealKey = GlobalKey();
  Settings mySettings = Settings();

  void _freshGame() {
    setState(() {
      _counter++;
      boardKey.currentState.clearBoard();
      //board.currentState.clearBoard();
    });
  }

    void returnToWelcome() {
      Navigator.pop(context);
    }

 _showSequence() {
   mySettings.toggleShowSequence();
   boardKey.currentState.updateBoxes();
   revealKey.currentState.toggleMe();
  //  setState(() {
  //    // boardKey.currentState.build(context);
  //  });

 }
 _determineChange(changed) {
   developer.log(changed.toString());
   // we get a boolean back from the Settings Editor
   // and Only if the settings have changed
   // do we need to call set State

     if (changed) {
       setState(() {
          var settingsChanged = boardKey.currentState.setNewValues(); 
          if (settingsChanged) {
            boardKey.currentState.clearBoard();
          }
        });
     }
 }
 _settingsEditor() {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsEditor()))
        .then(
          (value) => _determineChange(value)
          // (value) => setState(() {
          //     // If the settings have changed, then we need to 
          //     // clear the Board and start a new one.

          //     // var settingsChanged = boardKey.currentState.setNewValues(); 
          //     // if (settingsChanged) {
          //     //   boardKey.currentState.clearBoard();
          //     // }
          //   })
      );

  }

  var onState = true;
  GlobalKey<BoardState> boardKey = GlobalKey();
  var board;

  @override
  Widget build(BuildContext context) {
    var board = Board(key: boardKey);
    var mySettings = Settings();
    var sensitivity = 8;
    var showSequence = false;

    if (mySettings.showSequence) {
      showSequence = true;
    }

    // Not sure if we need the Scaffold here or not - since we are not
    // using the appBar.  It's likely that we don't need it

    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: 
      
      GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Note: Sensitivity is integer used when you don't want to mess up vertical drag
            // developer.log(details.delta.dx.toString());
            if (details.delta.dx > sensitivity) {
              // Right Swipe
              returnToWelcome();
            } else if (details.delta.dx < -sensitivity) {
              //Left Swipe
               _settingsEditor();
            }
          },
          child:
      
      Container(
          color: Colors.blue[900],
          child: Stack(children: [
            // Image.asset('images/bkg1.jpg'),
            BkgImageWidget(),
            ColorFilterWidget(),
            Center(
              child: Padding( 
                 padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  board,
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    boxText("SL: " + mySettings.sequenceLength.toString())
                  ]),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavButton(
                            null,
                            returnToWelcome,
                            "",
                            Icon(Icons.navigate_before,
                                color: HexColor("#aa60c6f9"), size: 54.0), 65.0, 65.0, false),
                        NavButton(
                            revealKey,
                            _showSequence,
                            "",
                            Icon(Icons.visibility,
                                color: HexColor("#aa60c6f9"), size: 54.0), 65.0, 65.0, showSequence),
                    NavButton(
                            null,
                            _freshGame,
                            "",
                            Icon(Icons.add,
                                color: HexColor("#aa60c6f9"), size: 54.0), 65.0, 65.0, false),
                        NavButton(
                            null,
                            _settingsEditor,
                            "",
                            Icon(Icons.settings,
                                color: HexColor("#aa60c6f9"), size: 44.0), 65.0, 65.0, false),
                      ])
                ],
              ),
              ),
            )
          ])),
      )
      
    );
  }
}
