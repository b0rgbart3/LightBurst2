import 'package:flutter/material.dart';
// import 'dart:developer' as developer;
import '../components/board.dart';
import '../components/interface.dart';

class Game extends StatefulWidget {
  Game({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      boardKey.currentState.clearBoard();
      //board.currentState.clearBoard();
    });
  }

  var onState = true;
  GlobalKey<BoardState> boardKey = GlobalKey();
  var board;

  @override
  Widget build(BuildContext context) {
  var board = Board(key: boardKey);

    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Container(
         color: Colors.blue[900],

        child: Stack(
          children: [
            // Image.asset('images/bkg1.jpg'),
            BkgImageWidget(),
            ColorFilterWidget(),
            Center(

          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

              board
              
            ,
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      )]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.api),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
